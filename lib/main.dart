import 'package:animations/animations.dart';
import 'package:countdown/control.dart';
import 'package:countdown/debouncer.dart';
import 'package:countdown/display.dart';
import 'package:countdown/model.dart';
import 'package:countdown/preferences.dart';
import 'package:countdown/time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => Model(),
        child: const App(),
      ),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => CupertinoApp(
        title: 'Countdown',
        theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: GoogleFonts.robotoMono(color: CupertinoColors.label),
            dateTimePickerTextStyle: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        home: HomePage(
          title: 'Countdown',
          model: Provider.of<Model>(context, listen: false),
        ),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.model});

  final String title;

  final Model model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _debouncer = Debouncer();
  Future<String> initModel() async {
    await load(widget.model);
    widget.model.addListener(() {
      _debouncer.debounce(
        duration: Duration(milliseconds: 500),
        onDebounce: () => save(widget.model),
      );
    });
    await Future.delayed(Duration(milliseconds: 500));
    return 'Init success';
  }

  List<Widget> buildLoading() => const <Widget>[
        SizedBox(
          width: 60,
          height: 60,
          child: CupertinoActivityIndicator(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Awaiting init...'),
        ),
      ];

  List<Widget> buildError(AsyncSnapshot<String> snapshot) => <Widget>[
        const Icon(
          CupertinoIcons.exclamationmark_circle_fill,
          color: CupertinoColors.destructiveRed,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: ${snapshot.error}'),
        ),
      ];

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: FutureBuilder(
          future: initModel(),
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return _MainPage();
            } else if (snapshot.hasError) {
              children = buildError(snapshot);
            } else {
              children = buildLoading();
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            );
          },
        ),
      );
}

class _MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final CurvedAnimation _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 240,
            child: PageTransitionSwitcher(
              transitionBuilder: (
                Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: CupertinoColors.transparent,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Provider.of<Model>(context).playing
                  ? const Center(key: ValueKey('Display'), child: Display())
                  : const Center(
                      key: ValueKey('TimePicker'),
                      child: TimePicker(),
                    ),
            ),
          ),
          const Control(),
        ],
      ),
    );
  }
}

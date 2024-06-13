import 'package:animations/animations.dart';
import 'package:countdown/control.dart';
import 'package:countdown/display.dart';
import 'package:countdown/model.dart';
import 'package:countdown/preferences.dart';
import 'package:countdown/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
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
  Widget build(BuildContext context) => MaterialApp(
        title: 'Countdown',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
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
  Future<String> initModel() async {
    await load(widget.model);
    widget.model.addListener(() => save(widget.model));
    await Future.delayed(Durations.long2);
    return "Init success";
  }

  List<Widget> buildLoading() => const <Widget>[
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Awaiting init...'),
        ),
      ];

  List<Widget> buildError(AsyncSnapshot<String> snapshot) => <Widget>[
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: ${snapshot.error}'),
        ),
      ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FutureBuilder(
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
  late final AnimationController _controller = AnimationController.unbounded(
    vsync: this,
  )..animateWith(SpringSimulation(
      const SpringDescription(mass: 1, stiffness: 20, damping: 14), 0, 1, 0));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _controller,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 240,
            child: PageTransitionSwitcher(
              transitionBuilder: (Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Provider.of<Model>(context).playing
                  ? const Center(key: ValueKey("Display"), child: Display())
                  : const Center(
                      key: ValueKey("TimePicker"), child: TimePicker()),
            ),
          ),
          const Control(),
        ],
      ),
    );
  }
}

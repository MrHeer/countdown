import 'package:countdown/control.dart';
import 'package:countdown/display.dart';
import 'package:countdown/model.dart';
import 'package:countdown/preferences.dart';
import 'package:countdown/time_picker.dart';
import 'package:flutter/material.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    return "Init success";
  }

  List<Widget> buildPage(BuildContext context) => <Widget>[
        AnimatedCrossFade(
          duration: Durations.medium2,
          firstChild:
              const SizedBox(height: 240, child: Center(child: TimePicker())),
          secondChild:
              const SizedBox(height: 240, child: Center(child: Display())),
          crossFadeState: Provider.of<Model>(context).playing
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        const Control(),
      ];

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
              children = buildPage(context);
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

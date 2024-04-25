import 'package:countdown/control.dart';
import 'package:countdown/display.dart';
import 'package:countdown/model.dart';
import 'package:countdown/preferences.dart';
import 'package:countdown/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Model(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.model});

  final String title;

  final Model model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initModel() async {
    await load(widget.model);
    widget.model.addListener(() {
      save(widget.model);
    });
  }

  @override
  void initState() {
    super.initState();
    initModel();
  }

  @override
  void dispose() {
    super.dispose();
    widget.model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedCrossFade(
              duration: Durations.medium2,
              firstChild: SizedBox.fromSize(
                  size: const Size.fromHeight(240),
                  child: const Center(child: TimePicker())),
              secondChild: SizedBox.fromSize(
                  size: const Size.fromHeight(240),
                  child: const Center(child: Display())),
              crossFadeState: Provider.of<Model>(context).playing
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
            const Control(),
          ],
        ),
      ),
    );
  }
}

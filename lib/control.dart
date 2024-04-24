import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ControlState();
  }
}

class _ControlState extends State<Control> {
  late bool playing;

  @override
  void initState() {
    super.initState();
    playing = false;
  }

  void handlePressed() {
    setState(() {
      playing = !playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 80,
      onPressed: handlePressed,
      icon: AnimatedRotation(
        turns: playing ? 1 / 4 : 0,
        duration: Durations.medium1,
        child: AnimatedCrossFade(
            duration: Durations.medium1,
            firstChild: const Icon(Icons.play_arrow_rounded),
            secondChild: const Icon(Icons.stop_rounded),
            crossFadeState:
                playing ? CrossFadeState.showSecond : CrossFadeState.showFirst),
      ),
    );
  }
}

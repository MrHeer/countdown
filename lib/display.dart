import 'dart:async';

import 'package:countdown/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<Model>(context).time;

    return Column(
      children: [
        const Text("After"),
        _Countdown(time),
        const Text("To"),
        Text(
          time.format(context),
          style: const TextStyle(fontSize: 40),
        ),
      ],
    );
  }
}

class _Countdown extends StatefulWidget {
  const _Countdown(this.time);

  final TimeOfDay time;

  @override
  State<StatefulWidget> createState() {
    return _CountdownState();
  }
}

class _CountdownState extends State<_Countdown> {
  late final Timer timer;
  late TimeOfDay time;

  TimeOfDay getNewTime() {
    final now = DateTime.now();
    var time = DateTime(
        now.year, now.month, now.day, widget.time.hour, widget.time.minute);
    if (now.isAfter(time)) {
      time = time.add(const Duration(days: 1));
    }

    final duration = time.difference(now);

    return TimeOfDay(
        hour: duration.inHours,
        minute:
            duration.inMinutes - duration.inHours * Duration.minutesPerHour);
  }

  @override
  void initState() {
    super.initState();
    time = getNewTime();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        time = getNewTime();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      time.format(context),
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 80),
    );
  }
}

import 'dart:async';

import 'package:countdown/extensions.dart';
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
          time.format24Hour(),
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
  State<StatefulWidget> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  late final Timer timer;
  late TimeOfDay time;

  TimeOfDay getNewTime() {
    final now =
        DateTime.now().copyWith(second: 0, millisecond: 0, microsecond: 0);
    var time = now.copyWith(hour: widget.time.hour, minute: widget.time.minute);
    if (now.isAfter(time)) {
      time = time.add(const Duration(days: 1));
    }
    final duration = time.difference(now);
    return TimeOfDayConverter.fromDuration(duration);
  }

  @override
  void initState() {
    super.initState();
    time = getNewTime();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() => time = getNewTime());
    });
  }

  @override
  void didUpdateWidget(covariant _Countdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    time = getNewTime();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) => Text(
        time.format24Hour(),
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 80),
      );
}

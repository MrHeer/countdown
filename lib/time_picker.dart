import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      const TimeOfDay(hour: 8, minute: 0).format(context),
      style: const TextStyle(fontSize: 80),
    );
  }
}

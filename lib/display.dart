import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("After"),
        Text(
          const TimeOfDay(hour: 2, minute: 23).format(context),
          style: const TextStyle(fontSize: 80),
        ),
        const Text("To"),
        Text(
          const TimeOfDay(hour: 8, minute: 0).format(context),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

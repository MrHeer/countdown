import 'package:countdown/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("After"),
        Text(
          const TimeOfDay(hour: 2, minute: 23).format(context),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 80),
        ),
        const Text("To"),
        Text(
          Provider.of<Model>(context).time.format(context),
          style: const TextStyle(fontSize: 40),
        ),
      ],
    );
  }
}

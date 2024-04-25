import 'package:countdown/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<Model>(context).time.format(context),
      style: const TextStyle(fontSize: 80),
    );
  }
}

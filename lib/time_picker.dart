import 'package:countdown/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  void handleTap(BuildContext context) async {
    final model = Provider.of<Model>(context, listen: false);
    final time =
        await showTimePicker(context: context, initialTime: model.time);
    if (time != null) {
      model.time = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        handleTap(context);
      },
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        textStyle: const TextStyle(fontSize: 80),
      ),
      child: Text(
        Provider.of<Model>(context).time.format(context),
      ),
    );
  }
}

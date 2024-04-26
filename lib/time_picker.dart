import 'package:countdown/extensions.dart';
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
    return Card.filled(
      color: Theme.of(context).colorScheme.primaryContainer,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          handleTap(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text(
              Provider.of<Model>(context).time.format24Hour(),
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

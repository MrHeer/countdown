import 'package:countdown/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:provider/provider.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      initialDateTime: DateTime(
        0,
        1,
        1,
        model.time.hour,
        model.time.minute,
      ),
      use24hFormat: true,
      showTimeSeparator: true,
      onDateTimeChanged: (dateTime) {
        model.time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      },
    );
  }
}

import 'package:flutter/material.dart';

extension TimeOfDayConverter on TimeOfDay {
  String format24Hour() {
    final hour = this.hour.toString().padLeft(2, "0");
    final minute = this.minute.toString().padLeft(2, "0");
    return "$hour:$minute";
  }
}

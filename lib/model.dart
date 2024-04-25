import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  var _playing = false;
  var _time = TimeOfDay.now();

  set playing(bool playing) {
    _playing = playing;
    notifyListeners();
  }

  void toggle() {
    playing = !_playing;
  }

  bool get playing {
    return _playing;
  }

  set time(TimeOfDay time) {
    _time = time;
    notifyListeners();
  }

  TimeOfDay get time {
    return _time;
  }
}

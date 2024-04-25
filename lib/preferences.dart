import 'package:countdown/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Keys {
  static const playing = "playing";
  static const time = "time";
}

Future<void> save(Model model) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(Keys.playing, model.playing);
  await prefs.setInt(Keys.time, model.timeInMinutes);
}

Future<void> load(Model model) async {
  final prefs = await SharedPreferences.getInstance();
  model.playing = prefs.getBool(Keys.playing) ?? model.playing;
  model.timeInMinutes = prefs.getInt(Keys.time) ?? model.timeInMinutes;
}

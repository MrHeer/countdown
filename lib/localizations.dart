import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const CustomCupertinoLocalizations();

  @override
  String datePickerHour(int hour) {
    return hour.toString().padLeft(2, '0');
  }

  static Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(
        const CustomCupertinoLocalizations());
  }

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _CustomCupertinoLocalizationsDelegate();
}

class _CustomCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CustomCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      CustomCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(_CustomCupertinoLocalizationsDelegate old) => false;

  @override
  String toString() => 'CustomCupertinoLocalizations.delegate(en_US)';
}

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  ThemeMode getThemeMode() {
    final stored = _sharedPreference.getString(Preferences.themeMode);
    if (stored != null) {
      return ThemeMode.values.firstWhere(
        (m) => m.name == stored,
        orElse: () => ThemeMode.system,
      );
    }
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return _sharedPreference.setString(Preferences.themeMode, mode.name);
  }

  String getLocale() {
    return _sharedPreference.getString(Preferences.locale) ?? 'en';
  }

  Future<void> setLocale(String locale) {
    return _sharedPreference.setString(Preferences.locale, locale);
  }
}

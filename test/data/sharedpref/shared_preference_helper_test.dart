import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SharedPreferenceHelper', () {
    late SharedPreferenceHelper helper;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      helper = SharedPreferenceHelper(prefs);
    });

    group('getThemeMode', () {
      test('returns ThemeMode.system when no value stored', () {
        final mode = helper.getThemeMode();
        expect(mode, ThemeMode.system);
      });

      test(
        'returns ThemeMode.dark after setThemeMode(ThemeMode.dark)',
        () async {
          await helper.setThemeMode(ThemeMode.dark);
          final mode = helper.getThemeMode();
          expect(mode, ThemeMode.dark);
        },
      );

      test(
        'returns ThemeMode.light after setThemeMode(ThemeMode.light)',
        () async {
          await helper.setThemeMode(ThemeMode.light);
          final mode = helper.getThemeMode();
          expect(mode, ThemeMode.light);
        },
      );
    });

    group('getLocale', () {
      test("returns 'en' when no value stored", () {
        final locale = helper.getLocale();
        expect(locale, 'en');
      });

      test("returns 'fa' after setLocale('fa')", () async {
        await helper.setLocale('fa');
        final locale = helper.getLocale();
        expect(locale, 'fa');
      });
    });
  });
}

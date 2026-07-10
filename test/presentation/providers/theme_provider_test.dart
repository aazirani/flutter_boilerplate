import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_boilerplate/presentation/providers/theme_provider.dart';

void main() {
  group('ThemeController provider', () {
    late ProviderContainer container;
    late SharedPreferenceHelper helper;

    setUp(() async {
      GetIt.instance.reset();
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      helper = SharedPreferenceHelper(prefs);
      GetIt.instance.registerSingleton<SharedPreferenceHelper>(helper);
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
      GetIt.instance.reset();
    });

    test('initial state is ThemeMode.system when no pref stored', () {
      final mode = container.read(themeControllerProvider);
      expect(mode, ThemeMode.system);
    });

    test('setThemeMode(ThemeMode.dark) updates state', () async {
      await container
          .read(themeControllerProvider.notifier)
          .setThemeMode(ThemeMode.dark);

      final mode = container.read(themeControllerProvider);
      expect(mode, ThemeMode.dark);
    });

    test('setThemeMode(ThemeMode.light) updates state', () async {
      await container
          .read(themeControllerProvider.notifier)
          .setThemeMode(ThemeMode.light);

      final mode = container.read(themeControllerProvider);
      expect(mode, ThemeMode.light);
    });

    test('setThemeMode persists to SharedPreferences', () async {
      await container
          .read(themeControllerProvider.notifier)
          .setThemeMode(ThemeMode.dark);

      // Verify persisted
      final storedMode = helper.getThemeMode();
      expect(storedMode, ThemeMode.dark);
    });

    test('currentThemeMode provider watches themeControllerProvider', () {
      final mode = container.read(currentThemeModeProvider);
      expect(mode, ThemeMode.system);
    });
  });
}

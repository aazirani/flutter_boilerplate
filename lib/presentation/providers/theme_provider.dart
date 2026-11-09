import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    return ServiceLocator.getIt<SharedPreferenceHelper>().getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ServiceLocator.getIt<SharedPreferenceHelper>().setThemeMode(mode);
  }
}

@Riverpod(keepAlive: true)
ThemeMode currentThemeMode(Ref ref) => ref.watch(themeControllerProvider);

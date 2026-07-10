import 'dart:ui' as ui;

import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:flutter_boilerplate/domain/entities/language/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

const List<Language> kSupportedLanguages = [
  Language(
    code: 'US',
    locale: 'en',
    language: 'English',
    englishName: 'English',
    flagEmoji: '🇺🇸',
    isRTL: false,
  ),
  Language(
    code: 'IR',
    locale: 'fa',
    language: 'فارسی',
    englishName: 'Persian',
    flagEmoji: '🇮🇷',
    isRTL: true,
    fontFamily: 'Vazirmatn',
    fontFallback: ['Vazirmatn', 'Tahoma'],
  ),
];

@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  @override
  String build() {
    final savedLocale = ServiceLocator.getIt<SharedPreferenceHelper>()
        .getLocale();
    if (savedLocale != 'en') {
      return savedLocale;
    }
    _init();
    return savedLocale;
  }

  Future<void> _init() async {
    final deviceLocale = ui.PlatformDispatcher.instance.locale.languageCode;
    final supportedLanguage = kSupportedLanguages.firstWhere(
      (lang) => lang.locale == deviceLocale,
      orElse: () => kSupportedLanguages.first,
    );
    state = supportedLanguage.locale;
  }

  void changeLanguage(String locale) {
    state = locale;
    ServiceLocator.getIt<SharedPreferenceHelper>().setLocale(locale);
  }

  Language getCurrentLanguage() {
    return kSupportedLanguages.firstWhere(
      (lang) => lang.locale == state,
      orElse: () => kSupportedLanguages.first,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_boilerplate/presentation/providers/language_provider.dart';

void main() {
  group('LanguageController provider', () {
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

    test('initial state returns saved locale when "en" stored', () {
      final locale = container.read(languageControllerProvider);
      expect(locale, 'en');
    });

    test('changeLanguage("fa") updates state', () {
      container.read(languageControllerProvider.notifier).changeLanguage('fa');

      final locale = container.read(languageControllerProvider);
      expect(locale, 'fa');
    });

    test('changeLanguage("en") updates state', () {
      container.read(languageControllerProvider.notifier).changeLanguage('en');

      final locale = container.read(languageControllerProvider);
      expect(locale, 'en');
    });

    test('changeLanguage persists to SharedPreferences', () async {
      container.read(languageControllerProvider.notifier).changeLanguage('fa');

      // Verify persisted
      final storedLocale = helper.getLocale();
      expect(storedLocale, 'fa');
    });

    test('getCurrentLanguage returns Language for current state', () {
      container.read(languageControllerProvider.notifier).changeLanguage('fa');
      final language = container
          .read(languageControllerProvider.notifier)
          .getCurrentLanguage();
      expect(language.locale, 'fa');
      expect(language.englishName, 'Persian');
      expect(language.isRTL, isTrue);
    });

    test(
      'getCurrentLanguage defaults to first language for unknown locale',
      () {
        container
            .read(languageControllerProvider.notifier)
            .changeLanguage('zz');
        final language = container
            .read(languageControllerProvider.notifier)
            .getCurrentLanguage();
        expect(language.locale, 'en');
      },
    );
  });
}

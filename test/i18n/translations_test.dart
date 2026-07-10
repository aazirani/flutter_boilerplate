import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Translations', () {
    late Map<String, dynamic> enJson;
    late Map<String, dynamic> faJson;

    setUp(() {
      final enFile = File('assets/lang/en.json');
      final faFile = File('assets/lang/fa.json');

      expect(
        enFile.existsSync(),
        isTrue,
        reason: 'en.json not found at assets/lang/en.json',
      );
      expect(
        faFile.existsSync(),
        isTrue,
        reason: 'fa.json not found at assets/lang/fa.json',
      );

      enJson = jsonDecode(enFile.readAsStringSync()) as Map<String, dynamic>;
      faJson = jsonDecode(faFile.readAsStringSync()) as Map<String, dynamic>;
    });

    test('en.json and fa.json have the same keys', () {
      final enKeys = enJson.keys.toSet();
      final faKeys = faJson.keys.toSet();

      final enOnly = enKeys.difference(faKeys);
      final faOnly = faKeys.difference(enKeys);

      expect(
        enOnly,
        isEmpty,
        reason: 'Keys in en.json but not in fa.json: $enOnly',
      );
      expect(
        faOnly,
        isEmpty,
        reason: 'Keys in fa.json but not in en.json: $faOnly',
      );
    });

    test('en.json has no empty values', () {
      for (final entry in enJson.entries) {
        if (entry.key == 'items_count') continue; // placeholder pattern
        expect(
          entry.value,
          isA<String>(),
          reason: 'Key "${entry.key}" is not a String',
        );
        expect(
          (entry.value as String).isNotEmpty,
          isTrue,
          reason: 'Key "${entry.key}" has empty value',
        );
      }
    });

    test('fa.json has no empty values', () {
      for (final entry in faJson.entries) {
        if (entry.key == 'items_count') continue; // placeholder pattern
        expect(
          entry.value,
          isA<String>(),
          reason: 'Key "${entry.key}" is not a String',
        );
        expect(
          (entry.value as String).isNotEmpty,
          isTrue,
          reason: 'Key "${entry.key}" has empty value',
        );
      }
    });

    test('specific English translations are correct', () {
      expect(enJson['app_name'], 'Flutter Boilerplate');
      expect(enJson['home'], 'Home');
      expect(enJson['settings'], 'Settings');
      expect(enJson['theme'], 'Theme');
      expect(enJson['language'], 'Language');
      expect(enJson['retry'], 'Retry');
      expect(enJson['save'], 'Save');
      expect(enJson['cancel'], 'Cancel');
      expect(enJson['delete'], 'Delete');
      expect(enJson['edit'], 'Edit');
      expect(enJson['add_item'], 'Add Item');
      expect(enJson['welcome'], 'Welcome');
    });

    test('specific Persian translations are correct', () {
      expect(faJson['home'], 'خانه');
      expect(faJson['settings'], 'تنظیمات');
      expect(faJson['theme'], 'پوسته');
      expect(faJson['language'], 'زبان');
      expect(faJson['retry'], 'تلاش مجدد');
      expect(faJson['save'], 'ذخیره');
      expect(faJson['cancel'], 'لغو');
      expect(faJson['delete'], 'حذف');
      expect(faJson['edit'], 'ویرایش');
      expect(faJson['welcome'], 'خوش آمدید');
    });

    test('both files have expected key count', () {
      expect(enJson.length, 51);
      expect(faJson.length, 51);
    });
  });
}

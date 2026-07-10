import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_boilerplate/presentation/providers/theme_provider.dart';
import 'package:flutter_boilerplate/presentation/providers/language_provider.dart';

// ignore_for_file: deprecated_member_use
// RadioGroup (Flutter 3.32+) not used to maintain backward compatibility with Flutter 3.10+

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    final currentLocale = ref.watch(languageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: Text(_themeModeLabel(themeMode)),
            trailing: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.brightness_auto),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (modes) {
                ref
                    .read(themeControllerProvider.notifier)
                    .setThemeMode(modes.first);
              },
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(
              kSupportedLanguages
                  .firstWhere((l) => l.locale == currentLocale)
                  .englishName,
            ),
            onTap: () => _showLanguagePicker(context, ref, currentLocale),
          ),
        ],
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    String currentLocale,
  ) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: kSupportedLanguages.map((language) {
          return RadioListTile<String>(
            title: Text('${language.flagEmoji} ${language.englishName}'),
            value: language.locale,
            groupValue: currentLocale,
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(languageControllerProvider.notifier)
                    .changeLanguage(value);
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

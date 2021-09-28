import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_selector_provider.dart';

class ThemeSelectorPage extends ConsumerWidget {
  const ThemeSelectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeSelectorProvider.notifier);
    final currentThemeMode = ref.watch(themeSelectorProvider);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: ThemeMode.values.length,
      itemBuilder: (_, index) {
        final themeMode = ThemeMode.values[index];
        return RadioListTile<ThemeMode>(
          value: themeMode,
          groupValue: currentThemeMode,
          onChanged: (newTheme) => themeSelector.changeAndSave(newTheme!),
          title: const Text('describeEnum(themeMode)'),
        );
      },
    );
  }
}

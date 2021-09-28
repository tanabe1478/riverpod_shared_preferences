import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_shared_preferences/shared_preferences_provider.dart';
import 'package:riverpod_shared_preferences/theme_selector_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeSelectorProvider),
      home: Scaffold(
        body: Center(
          child: ThemeSelectorPage(),
        ),
        appBar: AppBar(
          title: const Text('StateNotifierでテーマ変更'),
        ),
      ),
    );
  }
}

class ThemeSelectorPage extends ConsumerWidget {
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
          title: Text('describeEnum(themeMode)'),
        );
      },
    );
  }
}

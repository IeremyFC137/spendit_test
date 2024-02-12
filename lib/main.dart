import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spendit_test/config/config.dart';
import 'package:spendit_test/features/auth/presentation/providers/providers.dart';

import 'features/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initEnvironment();

  final keyValueStorageService = KeyValueStorageServiceImpl();

  final selectedColorIndex =
      await keyValueStorageService.getValue<int>('colorTheme') ?? 0;
  final isDarkMode =
      await keyValueStorageService.getValue<bool>('isDarkMode') ?? false;

  runApp(
    ProviderScope(
      overrides: [
        // Utiliza overrideWith para sobrescribir el provider
        themeNotifierProvider.overrideWith(
          (ref) => ThemeNotifier(
            AppTheme(selectedColor: selectedColorIndex, isDarkmode: isDarkMode),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Spendit',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      supportedLocales: [
        const Locale('es', ''), // Español
        const Locale('en', ''), // Inglés
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendit_test/config/config.dart';
import 'package:spendit_test/features/auth/presentation/providers/providers.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
        title: 'SPENDIT CESEL DEMO',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: appTheme.getTheme());
  }
}

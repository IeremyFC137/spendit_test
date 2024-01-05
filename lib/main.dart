import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendit_test/config/theme/app_theme.dart';
import 'package:spendit_test/presentation/screens/menu_screen.dart';

void main() {
  Get.lazyPut<MyDrawerController>(() => MyDrawerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CESEL DEMO',
        theme: AppTheme(selectedColor: 1).getTheme(),
        home: const MyDrawer());
  }
}

import 'package:flutter/material.dart';
import 'package:spendit_test/shared/widgets/app_bar_widget.dart';

class ScanitScreen extends StatelessWidget {
  const ScanitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(title: "Scanit"),
        body: Text("Simulación"));
  }
}

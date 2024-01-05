import 'package:flutter/material.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

class ScanitScreen extends StatelessWidget {
  const ScanitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
        appBar: const AppBarWidget(title: "Scanit"),
        body: const Text("Simulación"));
  }
}

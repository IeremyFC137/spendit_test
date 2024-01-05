import 'package:flutter/material.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

class GastosScreen extends StatelessWidget {
  static const name = "gastos_screen";

  const GastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
        appBar: const AppBarWidget(title: "Gastos"),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [Text("Pantalla Gastos")],
            ),
          ),
        ));
  }
}

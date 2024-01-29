import 'package:flutter/material.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

class IngresoManualScreen extends StatelessWidget {
  static const name = "ingreso_manual_screen";
  const IngresoManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: AppBarWidget(title: "Ingreso manual"),
      body: Center(child: Text("Formulario")),
    );
  }
}

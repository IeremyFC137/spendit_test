import 'package:flutter/material.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

import '../../../../shared/shared.dart';

class FondosScreen extends StatelessWidget {
  static const name = 'fondos_screen';

  const FondosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: const AppBarWidget(title: "Fondos"),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [Text("Pantalla Fondos")],
          ),
        ),
      ),
      bottomNavigationBar: FastAccessWidget(
        selectedIndex: 3,
        routeMap: {
          0: '/gastos',
          1: '/rendicion',
          2: '/revision',
          3: '/fondos',
        },
      ),
    );
  }
}

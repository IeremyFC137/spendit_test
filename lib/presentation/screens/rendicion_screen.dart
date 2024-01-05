import 'package:flutter/material.dart';
import 'package:spendit_test/shared/widgets/app_bar_widget.dart';

class RendicionScreen extends StatelessWidget {
  const RendicionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.inversePrimary,
        appBar: const AppBarWidget(title: "Rendición"),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [Text("Pantalla Rendición")],
            ),
          ),
        ));
  }
}

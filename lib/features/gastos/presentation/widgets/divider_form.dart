import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';

class DividerForm extends ConsumerWidget {
  const DividerForm({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          color: !ref.read(themeNotifierProvider).isDarkmode
              ? colors.primary
              : colors.onPrimary, // Color de la línea
          height: 0.5, // Altura de la línea para hacerla delgada
          width: double
              .infinity, // Ancho máximo para extender a lo largo de la pantalla
        ),
        Container(
          color: !ref.read(themeNotifierProvider).isDarkmode
              ? Colors.white
              : colors.primary,
          height: 15,
        ),
      ],
    );
  }
}

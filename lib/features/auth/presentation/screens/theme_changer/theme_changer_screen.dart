import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:spendit_test/features/auth/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.center, child: Text('Cambiar tema')),
        actions: [
          IconButton(
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onPressed: () {
                // ref.read(isDarkmodeProvider.notifier)
                //   .update((state) => !state );
                ref.read(themeNotifierProvider.notifier).toggleDarkmode();
              })
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    final List<String> nameColors = ref.watch(nameListProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;
    // final int selectedColor = ref.watch( selectedColorProvider );
    final currentColor = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text("Eliga el color de su preferencia:",
            style: TextStyle(color: currentColor.primary, fontSize: 17)),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final Color color = colors[index];

              return RadioListTile(
                title: Text(nameColors[index],
                    style:
                        TextStyle(color: color, fontWeight: FontWeight.bold)),
                activeColor: color,
                value: index,
                groupValue: selectedColor,
                onChanged: (value) {
                  // ref.read(selectedColorProvider.notifier).state = index;
                  ref
                      .watch(themeNotifierProvider.notifier)
                      .changeColorIndex(index);
                },
              );
            },
          ),
        )
      ],
    );
  }
}

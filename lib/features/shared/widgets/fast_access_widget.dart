import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../auth/presentation/providers/providers.dart';

typedef RouteMap = Map<int, String>;

class FastAccessWidget extends ConsumerWidget {
  final int selectedIndex;
  final RouteMap routeMap;

  const FastAccessWidget({
    Key? key,
    required this.selectedIndex,
    required this.routeMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.filePen),
          label: 'Gastos',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
          label: 'Rendición',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlassDollar),
          label: 'Revisión',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.handHoldingDollar),
          label: 'Fondos',
        ),
      ],
      currentIndex: selectedIndex,
      backgroundColor: !ref.read(themeNotifierProvider).isDarkmode
          ? colors.primary
          : colors.onPrimary,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        switch (index) {
          case 0:
            context.pushReplacement('/gastos');
            break;
          case 1:
            context.pushReplacement('/rendicion');
            break;
          case 2:
            context.pushReplacement('/revision');
            break;
          case 3:
            context.pushReplacement('/fondos');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}

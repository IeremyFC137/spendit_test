import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';
import 'package:spendit_test/features/gastos/presentation/widgets/gasto_card.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';
import 'package:spendit_test/features/shared/shared.dart';

import '../../../auth/presentation/providers/providers.dart';

class GastosScreen extends ConsumerStatefulWidget {
  static const name = "gastos_screen";

  const GastosScreen({super.key});

  @override
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(gastosProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool isDialOpen = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final gastosState = ref.watch(gastosProvider);
    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: AppBarWidget(
          title: "Gastos",
          icon: IconButton(onPressed: () => {}, icon: Icon(Icons.search))),
      body: gastosState.isLoading && gastosState.gastos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: scrollController,
              itemCount: gastosState.gastos.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final gasto = gastosState.gastos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: GestureDetector(
                        onTap: () => context.push('/gastos/${gasto.id}'),
                        child: GastoCard(gasto: gasto)),
                  ),
                );
              }),
      floatingActionButton: SpeedDial(
        icon: isDialOpen ? Icons.close : Icons.add,
        activeIcon: Icons.close,
        onOpen: () => setState(() => isDialOpen = true),
        onClose: () => setState(() => isDialOpen = false),
        backgroundColor: !isDialOpen
            ? (!ref.read(themeNotifierProvider).isDarkmode
                ? colors.primary
                : colors.onPrimary)
            : Colors.red,
        buttonSize: Size(55.0, 55.0),
        childrenButtonSize: Size(55.0, 55.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        spaceBetweenChildren: 30,
        visible: true,
        overlayOpacity: 0.6,
        overlayColor: Colors.black,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child:
                  FaIcon(FontAwesomeIcons.robot, color: Colors.white, size: 23),
              backgroundColor: Colors.blue,
              label: 'Scanit',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              labelBackgroundColor: Colors.transparent,
              labelShadow: [],
              onTap: () => context.push("/gastos/scanit"),
              shape: CircleBorder()),
          SpeedDialChild(
              child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 23),
              backgroundColor: Colors.blue,
              label: 'Escanear código',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              labelBackgroundColor: Colors.transparent,
              labelShadow: [],
              onTap: () => print("Escanear código"),
              shape: CircleBorder()),
          SpeedDialChild(
              child: FaIcon(FontAwesomeIcons.filePen,
                  color: Colors.white, size: 23),
              backgroundColor: Colors.blue,
              label: 'Ingreso manual',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              labelBackgroundColor: Colors.transparent,
              labelShadow: [],
              onTap: () => context.push("/gastos/ingreso-manual"),
              shape: CircleBorder()),
        ],
      ),
      bottomNavigationBar: FastAccessWidget(
        selectedIndex: 0,
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

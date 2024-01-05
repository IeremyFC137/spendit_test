import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:spendit_test/presentation/screens/fondos_screen.dart';
import 'package:spendit_test/presentation/screens/gastos/gastos_screen.dart';
import 'package:spendit_test/presentation/screens/home_screen.dart';
import 'package:spendit_test/presentation/screens/rendicion_screen.dart';
import 'package:spendit_test/presentation/screens/revision_screen.dart';

int drawerIndexPage = 0;

class MyDrawer extends GetView<MyDrawerController> {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.drawerController,
        menuScreen: const MenuScreen(),
        mainScreen: menu(),
        borderRadius: 60.0,
        showShadow: true,
        mainScreenTapClose: true,
        style: DrawerStyle.style1,
        angle: 0,
        openCurve: Curves.decelerate,
        closeCurve: Curves.decelerate,
        menuBackgroundColor: colors.inversePrimary,
        slideWidth: MediaQuery.of(context).size.width * 1.15,
      ),
    );
  }
}

class MenuScreen extends GetView<MyDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  controller.toggleDrawer();
                },
              )),
          const Spacer(flex: 3),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
                onPressed: () {
                  drawerIndexPage = 0;
                  controller.toggleDrawer();
                  controller.update();
                },
                child: const Row(
                  children: [
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(width: 15),
                    Text("Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
                onPressed: () {
                  drawerIndexPage = 1;
                  controller.toggleDrawer();
                  controller.update();
                },
                child: const Row(
                  children: [
                    Icon(Icons.account_balance, color: Colors.white),
                    SizedBox(width: 15),
                    Text("Gastos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
                onPressed: () {
                  drawerIndexPage = 2;
                  controller.toggleDrawer();
                  controller.update();
                },
                child: const Row(
                  children: [
                    Icon(Icons.money, color: Colors.white),
                    SizedBox(width: 15),
                    Text("Rendicion",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
                onPressed: () {
                  drawerIndexPage = 3;
                  controller.toggleDrawer();
                  controller.update();
                },
                child: const Row(
                  children: [
                    Icon(Icons.manage_accounts, color: Colors.white),
                    SizedBox(width: 15),
                    Text("Revision",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
                onPressed: () {
                  drawerIndexPage = 4;
                  controller.toggleDrawer();
                  controller.update();
                },
                child: const Row(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.white),
                    SizedBox(width: 15),
                    Text("Fondos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ],
                )),
          ),
          const Spacer(flex: 3),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Versión 1.0 - 2023 - Desarrollado por GTIC / Cesel S.A. All Rights Reserved',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    ));
  }
}

Widget menu() {
  switch (drawerIndexPage) {
    case 0:
      return const HomeScreen();
    case 1:
      return const GastosScreen();
    case 2:
      return const RendicionScreen();
    case 3:
      return const RevisionScreen();
    case 4:
      return const FondosScreen();
  }
  return const Scaffold();
}

class MyDrawerController extends GetxController {
  final drawerController = ZoomDrawerController();

  void toggleDrawer() {
    drawerController.toggle?.call();
    update();
  }
}

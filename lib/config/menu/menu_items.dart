import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Home',
      subTitle: 'Pantalla principal',
      link: '/home',
      icon: Icons.add),
  MenuItem(
      title: 'Gastos',
      subTitle: 'Registro de gastos',
      link: '/gastos',
      icon: Icons.smart_button_outlined),
  MenuItem(
      title: 'Rendición',
      subTitle: 'Registro de rendición',
      link: '/rendicion',
      icon: Icons.credit_card),
  MenuItem(
      title: 'Revisión',
      subTitle: 'Registro de revision',
      link: '/revision',
      icon: Icons.refresh_rounded),
  MenuItem(
      title: 'Fondos',
      subTitle: 'Registro de fondo',
      link: '/fondos',
      icon: Icons.info_outline),
];

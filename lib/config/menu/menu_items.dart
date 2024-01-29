import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      link: '/',
      icon: Icons.home),
  MenuItem(
      title: 'Cambiar tema',
      subTitle: 'Cambiar tema de la aplicación',
      link: '/theme-changer',
      icon: Icons.color_lens_outlined),
  MenuItem(
      title: 'Gastos',
      subTitle: 'Registro de gastos',
      link: '/gastos',
      icon: FontAwesomeIcons.filePen),
  MenuItem(
      title: 'Rendición',
      subTitle: 'Registro de rendición',
      link: '/rendicion',
      icon: FontAwesomeIcons.fileInvoiceDollar),
  MenuItem(
      title: 'Fondos',
      subTitle: 'Registro de fondos',
      link: '/fondos',
      icon: FontAwesomeIcons.handHoldingDollar),
  MenuItem(
      title: 'Revisión',
      subTitle: 'Registro de revision',
      link: '/revision',
      icon: FontAwesomeIcons.magnifyingGlassDollar),
];

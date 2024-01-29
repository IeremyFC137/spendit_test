import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? icon;
  const AppBarWidget({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), centerTitle: true, actions: [
      icon ??
          Image.asset(
            "assets/img/spendit.png",
            // 'assets/SupervisorAppIcon.png',
            width: 33,
            height: 33,
          ),
      const SizedBox(
        width: 10,
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

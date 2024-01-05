import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          // const Align(
          alignment: Alignment.centerLeft,
          child: Text("$title - (Prueba)"
              // ,style: TextStyle(
              //   fontSize: 20,
              // ),
              ),
        ),
        Image.asset(
          "assets/img/spendit.png",
          // 'assets/SupervisorAppIcon.png',
          width: 33,
          height: 33,
        ),
      ],
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

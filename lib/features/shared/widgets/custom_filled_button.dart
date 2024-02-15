import 'package:flutter/material.dart';

import 'loading_dots_widget.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final bool isLoading;
  final Widget? icon; // Nuevo parámetro para el ícono

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.isLoading = false,
    this.icon, // Añadir aquí
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    return ElevatedButton(
      style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: radius, bottomRight: radius, topLeft: radius))),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? LoadingDots()
          : icon != null // Verifica si se proporcionó un ícono
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon!, // Asegúrate de que el ícono no sea nulo aquí
                    const SizedBox(width: 8), // Espacio entre ícono y texto
                    Text(text),
                  ],
                )
              : Text(text),
    );
  }
}

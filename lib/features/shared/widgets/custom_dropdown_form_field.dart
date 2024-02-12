import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/providers/providers.dart';

class CustomDropdownFormField<T> extends ConsumerWidget {
  final bool isTopField; // La idea es que tenga bordes redondeados arriba
  final bool isBottomField; // La idea es que tenga bordes redondeados abajo
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? label;
  final String? hint;
  final int maxLines;
  final String? errorMessage;
  final Function(T?)? onChanged;
  final bool enabled;

  const CustomDropdownFormField(
      {super.key,
      this.maxLines = 1,
      this.value,
      required this.items,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChanged,
      this.isTopField = false,
      this.isBottomField = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return Container(
      decoration: BoxDecoration(
          color: !ref.read(themeNotifierProvider).isDarkmode
              ? Colors.white
              : colors.primary,
          borderRadius: BorderRadius.only(
            topLeft: isTopField ? borderRadius : Radius.zero,
            topRight: isTopField ? borderRadius : Radius.zero,
            bottomLeft: isBottomField ? borderRadius : Radius.zero,
            bottomRight: isBottomField ? borderRadius : Radius.zero,
          ),
          boxShadow: [
            if (isBottomField)
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 5,
                  offset: const Offset(0, 3))
          ]),
      child: DropdownButtonFormField<T>(
        value: value,
        onChanged: enabled ? onChanged : null,
        items: items,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        dropdownColor: !ref.read(themeNotifierProvider).isDarkmode
            ? Colors.white
            : colors.primary,
        decoration: InputDecoration(
          floatingLabelBehavior: maxLines > 2
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
              color: !ref.read(themeNotifierProvider).isDarkmode
                  ? Colors.black
                  : colors.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}

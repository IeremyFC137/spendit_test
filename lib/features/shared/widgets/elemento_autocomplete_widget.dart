import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendit_test/features/shared/shared.dart';

class ElementoAutocompleteWidget extends ConsumerWidget {
  final List<String> elementos;
  final void Function(String) onChanged;
  final bool isTopField;
  final bool isBottomField;
  final String? label;
  final String? hint;

  final bool obscureText;
  final String? errorMessage;
  final GlobalKey<FormState>? formKey;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  ElementoAutocompleteWidget({
    Key? key,
    this.formKey,
    required this.elementos,
    required this.onChanged,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.maxLines = 1,
    this.obscureText = false,
    this.errorMessage,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || textEditingValue.text.length < 2) {
          return const Iterable<String>.empty();
        }
        return elementos.where((String str) =>
            str.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (String option) => option,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmittedVoidCallback,
      ) {
        return CustomGastoField(
          focusNode: fieldFocusNode,
          controller: fieldTextEditingController,
          isBottomField: isBottomField,
          isTopField: isTopField,
          label: label,
          hint: hint,
          errorMessage: errorMessage,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          enabled: enabled,
        );
      },
      onSelected: (String selection) {
        onChanged(selection);
      },
    );
  }
}

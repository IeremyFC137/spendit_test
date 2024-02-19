import 'package:flutter/material.dart';
import 'package:spendit_test/features/shared/shared.dart';

class ElementoAutocompleteWidget extends StatefulWidget {
  final List<String> elementos;
  final void Function(String) onChanged;
  final bool isTopField;
  final bool isBottomField;
  final String? label;
  final String? hint;
  final bool obscureText;
  final String? errorMessage;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? initialValue;

  ElementoAutocompleteWidget({
    Key? key,
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
    this.initialValue,
  }) : super(key: key);

  @override
  _ElementoAutocompleteWidgetState createState() =>
      _ElementoAutocompleteWidgetState();
}

class _ElementoAutocompleteWidgetState
    extends State<ElementoAutocompleteWidget> {
  // Indicador para rastrear si el valor inicial ya ha sido asignado.
  bool _isInitialValueAssigned = false;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || textEditingValue.text.length < 2) {
          return const Iterable<String>.empty();
        }
        return widget.elementos.where((String option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (String option) => option,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmittedVoidCallback,
      ) {
        // Asigna el valor inicial solo una vez y si aún no se ha asignado.
        if (widget.initialValue != null && !_isInitialValueAssigned) {
          fieldTextEditingController.text = widget.initialValue!;
          _isInitialValueAssigned = true;
        }

        return CustomGastoField(
          focusNode: fieldFocusNode,
          controller: fieldTextEditingController,
          isBottomField: widget.isBottomField,
          isTopField: widget.isTopField,
          label: widget.label,
          hint: widget.hint,
          errorMessage: widget.errorMessage,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          enabled: widget.enabled,
        );
      },
      onSelected: (String selection) {
        widget.onChanged(selection);
      },
    );
  }
}

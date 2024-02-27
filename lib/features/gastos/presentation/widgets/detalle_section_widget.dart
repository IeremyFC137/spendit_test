import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import 'divider_form.dart';

class DetalleSectionWidget extends StatefulWidget {
  final int index;
  final List<String> listCcosto;
  final DetallesGasto detalle;
  final List<int>? ids;
  final Function(int, String) onCentroCostoChanged;
  final Function(int, String) onConceptoGastoChanged;
  final Function(int, String) onCuentaContableChanged;
  final Function(int, double) onImporteChanged;
  final Function(int, double) onPImporteChanged;
  final Function(int) removeDetalle;
  final String? errorMessageCcosto;
  final String? errorMessageCgasto;
  final String? errorMessageCcontable;
  final String? errorMessageImporte;
  final String? errorMessagePimporte;

  const DetalleSectionWidget({
    Key? key,
    required this.index,
    required this.listCcosto,
    required this.detalle,
    this.ids,
    required this.onCentroCostoChanged,
    required this.onConceptoGastoChanged,
    required this.onCuentaContableChanged,
    required this.onImporteChanged,
    required this.onPImporteChanged,
    required this.errorMessageCcontable,
    required this.errorMessageCcosto,
    required this.errorMessageCgasto,
    required this.errorMessagePimporte,
    required this.errorMessageImporte,
    required this.removeDetalle,
  }) : super(key: key);

  @override
  State<DetalleSectionWidget> createState() => _DetalleSectionWidgetState();
}

class _DetalleSectionWidgetState extends State<DetalleSectionWidget> {
  late TextEditingController _importeController;
  late TextEditingController _pImporteController;
  FocusNode _importeFocusNode = FocusNode();
  FocusNode _pImporteFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _importeController = TextEditingController();
    _pImporteController = TextEditingController();

    _setInitialValues();

    _importeFocusNode.addListener(() {
      if (!_importeFocusNode.hasFocus) {
        _updatePImporteFromImporte();
      }
    });

    _pImporteFocusNode.addListener(() {
      if (!_pImporteFocusNode.hasFocus) {
        _updateImporteFromPImporte();
      }
    });
  }

  void _setInitialValues() {
    _importeController.text =
        widget.detalle.importe == 0 ? '' : widget.detalle.importe.toString();
    _pImporteController.text = widget.detalle.pImporte == 0
        ? ''
        : (widget.detalle.pImporte * 100).toStringAsFixed(0);
  }

  void _updatePImporteFromImporte() {
    _pImporteController.text = widget.detalle.pImporte == 0
        ? ''
        : (widget.detalle.pImporte * 100).toStringAsFixed(0);
  }

  void _updateImporteFromPImporte() {
    _importeController.text =
        widget.detalle.importe == 0 ? '' : widget.detalle.importe.toString();
    ;
  }

  @override
  void dispose() {
    _importeController.dispose();
    _pImporteController.dispose();
    _importeFocusNode.dispose();
    _pImporteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Row(
              children: [
                Spacer(),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.deleteLeft,
                      color: Colors.red, size: 30),
                  onPressed: () => widget.removeDetalle(widget.index),
                ),
              ],
            ),
          ),
          DividerForm(),
          ElementoAutocompleteWidget(
            label: 'Centro de costo',
            maxLines: 2,
            keyboardType: TextInputType.text,
            elementos: widget.listCcosto,
            initialValue: widget.detalle.cCosto,
            validator: (value) {
              if (!widget.listCcosto.contains(value)) {
                return 'Selecciona un valor válido de la lista.';
              }
              if (value == null) {
                return 'El campo "Centro de costo" no puede estar en blanco';
              }
              return null;
            },
            onChanged: (value) =>
                widget.onCentroCostoChanged(widget.index, value),
            errorMessage: widget.errorMessageCcosto,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Concepto de gasto',
            initialValue: widget.detalle.cGasto,
            maxLines: 2,
            isTopField: false,
            keyboardType: TextInputType.text,
            onChanged: (value) =>
                widget.onConceptoGastoChanged(widget.index, value),
            errorMessage: widget.errorMessageCgasto,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Cuenta contable',
            initialValue: widget.detalle.cContable,
            isTopField: false,
            maxLines: 2,
            keyboardType: TextInputType.text,
            onChanged: (value) =>
                widget.onCuentaContableChanged(widget.index, value),
            errorMessage: widget.errorMessageCcontable,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Importe',
            controller: _importeController,
            maxLines: 2,
            focusNode: _importeFocusNode,
            isTopField: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              widget.onImporteChanged(widget.index, parsedValue ?? 0.0);
            },
            errorMessage: widget.errorMessageImporte,
          ),
          DividerForm(),
          CustomGastoField(
            label:
                "Porcentaje de importe (${(widget.detalle.pImporte * 100).toStringAsFixed(0)}%)",
            maxLines: 2,
            focusNode: _pImporteFocusNode,
            controller: _pImporteController,
            keyboardType: TextInputType.number,
            isBottomField: true,
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              widget.onPImporteChanged(
                  widget.index, (parsedValue ?? 0.0) / 100);
            },
            errorMessage: widget.errorMessagePimporte,
          ),
        ],
      ),
    );
  }
}

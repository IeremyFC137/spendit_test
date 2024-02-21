import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import 'divider_form.dart';

class DetalleSectionWidget extends StatelessWidget {
  final int index;
  final List<String> listCcosto;
  final DetallesGasto detalle;
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
                  onPressed: () => removeDetalle(index),
                ),
              ],
            ),
          ),
          DividerForm(),
          ElementoAutocompleteWidget(
            label: 'Centro de costo',
            maxLines: 2,
            keyboardType: TextInputType.text,
            elementos: listCcosto,
            initialValue: detalle.cCosto,
            validator: (value) {
              if (!listCcosto.contains(value)) {
                return 'Selecciona un valor válido de la lista.';
              }
              if (value == null) {
                return 'El campo "Centro de costo" no puede estar en blanco';
              }
              return null;
            },
            onChanged: (value) => onCentroCostoChanged(index, value),
            errorMessage: errorMessageCcosto,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Concepto de gasto',
            initialValue: detalle.cGasto,
            maxLines: 2,
            isTopField: false,
            keyboardType: TextInputType.text,
            onChanged: (value) => onConceptoGastoChanged(index, value),
            errorMessage: errorMessageCgasto,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Cuenta contable',
            initialValue: detalle.cContable,
            isTopField: false,
            maxLines: 2,
            keyboardType: TextInputType.text,
            onChanged: (value) => onCuentaContableChanged(index, value),
            errorMessage: errorMessageCcontable,
          ),
          DividerForm(),
          CustomGastoField(
            label: 'Importe',
            initialValue:
                detalle.importe == 0 ? '' : detalle.importe.toString(),
            maxLines: 2,
            isTopField: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              onImporteChanged(index, parsedValue ?? 0.0);
            },
            errorMessage: errorMessageImporte,
          ),
          DividerForm(),
          CustomGastoField(
            label:
                "Porcentaje de importe (${(detalle.pImporte * 100).toStringAsFixed(0)}%)",
            maxLines: 2,
            initialValue: detalle.pImporte == 0
                ? ''
                : (detalle.pImporte * 100).toStringAsPrecision(2),
            keyboardType: TextInputType.number,
            isBottomField: true,
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              onPImporteChanged(index, (parsedValue ?? 0.0) / 100);
            },
            errorMessage: errorMessagePimporte,
          ),
        ],
      ),
    );
  }
}

import '../../domain/domain.dart';
import '../providers/providers.dart';
import 'package:flutter/material.dart';

import 'detalle_section_widget.dart';

class DetallesWidget extends StatelessWidget {
  final GastoFormState gastoFormState;
  final List<String> listCcosto;
  final Function(int, String) onCentroCostoChanged;
  final Function(int, String) onConceptoGastoChanged;
  final Function(int, String) onCuentaContableChanged;
  final Function(int, double) onImporteChanged;
  final Function(int, double) onPImporteChanged;
  final Function(int) removeDetalle;

  const DetallesWidget({
    Key? key,
    required this.gastoFormState,
    required this.listCcosto,
    required this.onCentroCostoChanged,
    required this.onConceptoGastoChanged,
    required this.onCuentaContableChanged,
    required this.onImporteChanged,
    required this.onPImporteChanged,
    required this.removeDetalle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detalle = formarListaDetalles(gastoFormState);
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      child: PageView.builder(
        itemCount: gastoFormState.centrosCosto.length,
        itemBuilder: (context, index) {
          return DetalleSectionWidget(
            index: index,
            detalle: detalle[index],
            removeDetalle: removeDetalle,
            listCcosto: listCcosto,
            onCentroCostoChanged: onCentroCostoChanged,
            onConceptoGastoChanged: onConceptoGastoChanged,
            onCuentaContableChanged: onCuentaContableChanged,
            onImporteChanged: onImporteChanged,
            onPImporteChanged: onPImporteChanged,
            errorMessageCcosto: gastoFormState.isFormPosted
                ? gastoFormState.centrosCosto[index].errorMessage
                : null,
            errorMessageCgasto: gastoFormState.isFormPosted
                ? gastoFormState.conceptosGasto[index].errorMessage
                : null,
            errorMessageCcontable: gastoFormState.isFormPosted
                ? gastoFormState.cuentasContables[index].errorMessage
                : null,
            errorMessageImporte: gastoFormState.isFormPosted
                ? gastoFormState.importes[index].errorMessage
                : null,
            errorMessagePimporte: gastoFormState.isFormPosted
                ? gastoFormState.pimportes[index].errorMessage
                : null,
          );
        },
      ),
    );
  }
}

List<DetallesGasto> formarListaDetalles(GastoFormState gastoFormState) {
  List<DetallesGasto> detalles = [];
  for (int i = 0; i < gastoFormState.centrosCosto.length; i++) {
    detalles.add(
      DetallesGasto(
        id: 0,
        cCosto: gastoFormState.centrosCosto[i].value,
        cGasto: gastoFormState.conceptosGasto[i].value,
        cContable: gastoFormState.cuentasContables[i].value,
        importe: gastoFormState.importes[i].value,
        pImporte: gastoFormState.pimportes[i].value,
      ),
    );
  }
  return detalles;
}

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';
import 'package:flutter/material.dart';

import 'detalle_section_widget.dart';

class DetallesWidget extends StatefulWidget {
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
  State<DetallesWidget> createState() => _DetallesWidgetState();
}

class _DetallesWidgetState extends State<DetallesWidget> {
  final PageController _pageController = PageController();
  int _activeIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final detalles = formarListaDetalles(widget.gastoFormState);
    final colors = Theme.of(context).colorScheme;

    return Column(children: [
      AnimatedSmoothIndicator(
        activeIndex: _activeIndex,
        count: detalles.length,
        onDotClicked: _animateToSlide,
        effect: JumpingDotEffect(activeDotColor: colors.primary),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.87,
        child: PageView.builder(
          controller: _pageController,
          itemCount: detalles.length,
          itemBuilder: (context, index) {
            return DetalleSectionWidget(
              index: index,
              detalle: detalles[index],
              removeDetalle: widget.removeDetalle,
              listCcosto: widget.listCcosto,
              onCentroCostoChanged: widget.onCentroCostoChanged,
              onConceptoGastoChanged: widget.onConceptoGastoChanged,
              onCuentaContableChanged: widget.onCuentaContableChanged,
              onImporteChanged: widget.onImporteChanged,
              onPImporteChanged: widget.onPImporteChanged,
              errorMessageCcosto: widget.gastoFormState.isFormPosted
                  ? widget.gastoFormState.centrosCosto[index].errorMessage
                  : null,
              errorMessageCgasto: widget.gastoFormState.isFormPosted
                  ? widget.gastoFormState.conceptosGasto[index].errorMessage
                  : null,
              errorMessageCcontable: widget.gastoFormState.isFormPosted
                  ? widget.gastoFormState.cuentasContables[index].errorMessage
                  : null,
              errorMessageImporte: widget.gastoFormState.isFormPosted
                  ? widget.gastoFormState.importes[index].errorMessage
                  : null,
              errorMessagePimporte: widget.gastoFormState.isFormPosted
                  ? widget.gastoFormState.pimportes[index].errorMessage
                  : null,
            );
          },
          onPageChanged: (index) {
            setState(() => _activeIndex = index);
          },
        ),
      ),
    ]);
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';
import 'package:spendit_test/features/shared/shared.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

class GastoScreen extends ConsumerWidget {
  final String gastoId;
  static const name = "gasto_screen";

  const GastoScreen({super.key, required this.gastoId});

  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final gastoState = ref.watch(gastoProvider(int.parse(gastoId)));
    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: AppBarWidget(
          title: "Editar Gasto", icon: Icon(Icons.camera_alt_outlined)),
      body: gastoState.isLoading
          ? FullScreenLoader()
          : _GastoView(gasto: gastoState.gasto!),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.save_as_outlined)),
    );
  }
}

class _GastoView extends StatelessWidget {
  final Gasto gasto;

  const _GastoView({required this.gasto});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: []),
        ),
        const SizedBox(height: 10),
        Center(child: Text(gasto.proveedor, style: textStyles.titleSmall)),
        const SizedBox(height: 10),
        _GastoInformation(gasto: gasto),
      ],
    );
  }
}

class _GastoInformation extends ConsumerWidget {
  final Gasto gasto;
  const _GastoInformation({required this.gasto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15),
          CustomGastoField(
            isTopField: true,
            label: 'Proveedor',
            initialValue: gasto.proveedor,
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Ruc',
            initialValue: gasto.ruc,
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Tipo de documento',
            initialValue: gasto.tipoDocumento.name,
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Moneda',
            initialValue: gasto.moneda.name,
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Numero de documento',
            initialValue: gasto.documento,
          ),
          InkWell(
            onTap: () async {
              /*DateTime? pickedDate =*/ await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );

              /*if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  ref
                      .read(gastoFormProvider.notifier)
                      .onFechaEmisionChange(formattedDate);
                }*/
            },
            child: IgnorePointer(
              child: CustomGastoField(
                isTopField: false,
                label: 'Fecha de emision',
                keyboardType: TextInputType.datetime,
                initialValue: DateFormat('yyyy-MM-dd')
                    .format(gasto.fechaEmision)
                    .toString(),
              ),
            ),
          ),
          CustomGastoField(
            isBottomField: false,
            label: 'Sub total',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: gasto.subTotal.toString(),
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Igv',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: gasto.igv.toString(),
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Importe',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: gasto.importe.toString(),
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Porcentaje de importe',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: gasto.pImporte.toString(),
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Centro de costo',
            initialValue: gasto.cCosto,
          ),
          CustomGastoField(
            isTopField: false,
            label: 'Concepto de gasto',
            initialValue: gasto.cGasto,
          ),
          CustomGastoField(
            isTopField: false,
            isBottomField: true,
            label: 'Cuenta contable',
            initialValue: gasto.cContable,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.isEmpty
          ? [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SvgPicture.asset('assets/img/image.svg',
                      fit: BoxFit.cover))
            ]
          : images.map((e) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';
import 'package:spendit_test/features/shared/shared.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

import '../widgets/widgets.dart';

class GastoScreen extends ConsumerWidget {
  final String gastoId;
  static const name = "gasto_screen";

  const GastoScreen({super.key, required this.gastoId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
        content: Text('Gasto Actualizado')));
  }

  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final gastoState = ref.watch(gastoProvider(int.parse(gastoId)));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
        appBar: AppBarWidget(
            title: "Editar gasto",
            icon: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final photoPath =
                          await CameraGalleryServiceImpl().selectPhoto();
                      if (photoPath == null) return null;
                      ref
                          .read(gastoFormProvider(gastoState.gasto!).notifier)
                          .updateGastoImage(photoPath);
                    },
                    icon: Icon(Icons.photo_library_outlined)),
                IconButton(
                    onPressed: () async {
                      final photoPath =
                          await CameraGalleryServiceImpl().takePhoto();
                      if (photoPath == null) return null;
                      ref
                          .read(gastoFormProvider(gastoState.gasto!).notifier)
                          .updateGastoImage(photoPath);
                    },
                    icon: Icon(Icons.camera_alt_outlined)),
              ],
            )),
        body: gastoState.isLoading
            ? FullScreenLoader()
            : _GastoView(gasto: gastoState.gasto!),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (gastoState.gasto == null) return;
              ref
                  .read(gastoFormProvider(gastoState.gasto!).notifier)
                  .onFormActualizarSubmit()
                  .then((value) {
                if (!value) return;
                showSnackbar(context);
              });
            },
            child: const Icon(Icons.save_as_outlined)),
      ),
    );
  }
}

class _GastoView extends ConsumerWidget {
  final Gasto gasto;

  const _GastoView({required this.gasto});

  @override
  Widget build(BuildContext context, ref) {
    final gastoForm = ref.watch(gastoFormProvider(gasto));
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: gastoForm.images),
        ),
        const SizedBox(height: 10),
        Center(child: Text(gasto.proveedor, style: textStyles.titleSmall)),
        const SizedBox(height: 20),
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
    final colors = Theme.of(context).colorScheme;
    final gastoForm = ref.watch(gastoFormProvider(gasto));
    print(gastoForm);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              'Generales',
              style: TextStyle(
                  fontSize: 18,
                  color: colors.primary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 8,
            ),
            FaIcon(
              FontAwesomeIcons.globe,
            )
          ]),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Proveedor",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                gasto.proveedor,
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              Text("Ruc",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.ruc,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Tipo de documento",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.tipoDocumento.name,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Moneda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.moneda.name,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Numero de documento",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.documento,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Fecha de emisión",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  DateFormat('yyyy-MM-dd')
                      .format(gasto.fechaEmision)
                      .toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Sub total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.subTotal.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Igv",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gasto.igv.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
            ]),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Text('Detalles',
                style: TextStyle(
                    fontSize: 18,
                    color: colors.primary,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              width: 8,
            ),
            FaIcon(
              FontAwesomeIcons.circleInfo,
            )
          ]),
          const SizedBox(height: 20),
          CustomGastoField(
            isTopField: true,
            label: 'Importe',
            keyboardType: TextInputType.number,
            initialValue: "${gasto.importe}",
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              if (parsedValue == null) {
                ref
                    .read(gastoFormProvider(gasto).notifier)
                    .onImporteChange(0.0);
              } else {
                ref
                    .read(gastoFormProvider(gasto).notifier)
                    .onImporteChange(parsedValue);
              }
            },
            errorMessage:
                gastoForm.isFormPosted ? gastoForm.importe.errorMessage : null,
          ),
          DividerForm(),
          CustomGastoField(
            isTopField: false,
            label:
                "Porcentaje de importe (${(gastoForm.pimporte.value * 100).toStringAsFixed(0)}%)",
            keyboardType: TextInputType.number,
            initialValue: "${(gasto.pImporte * 100).round()}",
            onChanged: (value) {
              double? parsedValue = double.tryParse(value);
              if (parsedValue == null) {
                ref
                    .read(gastoFormProvider(gasto).notifier)
                    .onPimporteChange(0.0);
              } else {
                ref
                    .read(gastoFormProvider(gasto).notifier)
                    .onPimporteChange(parsedValue / 100);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Este campo es obligatorio';
              final numberValue = double.tryParse(value);
              if (numberValue == null) return 'Debe ser un número';
              if (numberValue < 0 || numberValue > 100)
                return 'Debe estar entre 0 y 100';
              return null;
            },
            errorMessage:
                gastoForm.isFormPosted ? gastoForm.pimporte.errorMessage : null,
          ),
          DividerForm(),
          CustomGastoField(
            isTopField: false,
            label: 'Centro de costo',
            initialValue: gasto.cCosto,
            onChanged:
                ref.read(gastoFormProvider(gasto).notifier).onCentroCostoChange,
            errorMessage: gastoForm.isFormPosted
                ? gastoForm.centroCosto.errorMessage
                : null,
          ),
          DividerForm(),
          CustomGastoField(
            isTopField: false,
            label: 'Concepto de gasto',
            initialValue: gasto.cGasto,
            onChanged: ref
                .read(gastoFormProvider(gasto).notifier)
                .onConceptoGastoChange,
            errorMessage: gastoForm.isFormPosted
                ? gastoForm.conceptoGasto.errorMessage
                : null,
          ),
          DividerForm(),
          CustomGastoField(
            isTopField: false,
            isBottomField: true,
            label: 'Cuenta contable',
            initialValue: gasto.cContable,
            onChanged: ref
                .read(gastoFormProvider(gasto).notifier)
                .onCuentaContableChange,
            errorMessage: gastoForm.isFormPosted
                ? gastoForm.cuentaContable.errorMessage
                : null,
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
          : images.map((image) {
              late ImageProvider imageProvider;
              if (image.startsWith("http")) {
                imageProvider = NetworkImage(image);
              } else {
                imageProvider = FileImage(File(image));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                    placeholder:
                        const AssetImage('assets/loaders/bottle-loader.gif'),
                  ),
                ),
              );
            }).toList(),
    );
  }
}

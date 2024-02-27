import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';
import 'package:spendit_test/features/shared/shared.dart';
import '../widgets/widgets.dart';

class GastoScreen extends ConsumerWidget {
  final String gastoId;
  static const name = "gasto_screen";

  const GastoScreen({super.key, required this.gastoId});

  void showSnackbar(
      BuildContext context, String message, Color color, int seconds) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        duration: Duration(seconds: seconds),
        content: Text(message)));
  }

  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final gastoState = ref.watch(gastoProvider(int.parse(gastoId)));

    GastoLike gastoLike = GastoLikeMapper.gastoToGastoLikeEntity(
        gastoState.gasto ??
            Gasto(
                id: 0,
                idUsuario: 0,
                proveedor: '',
                ruc: '',
                tipoDocumento: TipoDocumento.BOLETA,
                documento: '',
                fechaEmision: DateTime.now(),
                subTotal: 0.0,
                igv: 0.0,
                detalles: [],
                moneda: Moneda.SOLES,
                estado: '',
                images: []));

    List<int> ids = gastoLike.detalles!.map((detalle) => detalle.id).toList();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                          .read(gastoFormProvider(gastoLike).notifier)
                          .updateGastoImage(photoPath);
                    },
                    icon: Icon(Icons.photo_library_outlined)),
                IconButton(
                    onPressed: () async {
                      final photoPath =
                          await CameraGalleryServiceImpl().takePhoto();
                      if (photoPath == null) return null;
                      ref
                          .read(gastoFormProvider(gastoLike).notifier)
                          .updateGastoImage(photoPath);
                    },
                    icon: Icon(Icons.camera_alt_outlined)),
              ],
            )),
        body: gastoState.isLoading
            ? FullScreenLoader()
            : _GastoView(gastoLike: gastoLike),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (gastoState.gasto == null) return;
              ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onFormActualizarSubmit(ids)
                  .then((value) {
                if (!value) {
                  if (ref.watch(gastoFormProvider(gastoLike)).isValid) {
                    showSnackbar(
                        context, "Error al actualizar el gasto", Colors.red, 2);
                  } else {
                    showSnackbar(
                        context,
                        ref.watch(gastoFormProvider(gastoLike)).messageError,
                        Colors.red,
                        5);
                  }
                } else {
                  showSnackbar(context, 'Gasto actualizado', Colors.green, 3);
                }
              });
            },
            child: const Icon(Icons.save_as_outlined)),
      ),
    );
  }
}

class _GastoView extends ConsumerWidget {
  final GastoLike gastoLike;

  const _GastoView({required this.gastoLike});

  @override
  Widget build(BuildContext context, ref) {
    final gastoForm = ref.watch(gastoFormProvider(gastoLike));
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: gastoForm.images),
        ),
        const SizedBox(height: 10),
        Center(child: Text(gastoLike.proveedor!, style: textStyles.titleSmall)),
        const SizedBox(height: 20),
        _GastoInformation(gastoLike: gastoLike),
      ],
    );
  }
}

class _GastoInformation extends ConsumerWidget {
  final GastoLike gastoLike;

  const _GastoInformation({required this.gastoLike});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final gastoForm = ref.watch(gastoFormProvider(gastoLike));
    final listCcosto = ref.watch(gastosProvider).campoDetalle;
    print(gastoForm);
    print(gastoLike);
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
                gastoLike.proveedor!,
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              Text("Ruc",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.ruc!,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Tipo de documento",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.tipoDocumento!.name,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Moneda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.moneda!.name,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Numero de documento",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.documento!,
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Fecha de emisión",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  DateFormat('yyyy-MM-dd')
                      .format(gastoLike.fechaEmision!)
                      .toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Sub total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.subTotal!.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
              Text("Igv",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(gastoLike.igv!.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black54)),
            ]),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text("Detalles",
                  style: TextStyle(
                      fontSize: 18,
                      color: colors.primary,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 5,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidSquarePlus,
                    color: colors.primary, size: 30),
                onPressed: () => ref
                    .read(gastoFormProvider(gastoLike).notifier)
                    .addDetalle(),
              )
            ],
          ),
          const SizedBox(height: 20),
          /*Comienzo detalles actualizar*/
          DetallesWidget(
            gastoFormState: gastoForm,
            listCcosto: listCcosto,
            onCentroCostoChanged: ref
                .read(gastoFormProvider(gastoLike).notifier)
                .onCentrosCostoChange,
            onConceptoGastoChanged: ref
                .read(gastoFormProvider(gastoLike).notifier)
                .onConceptosGastoChange,
            onCuentaContableChanged: ref
                .read(gastoFormProvider(gastoLike).notifier)
                .onCuentasContableChange,
            onImporteChanged: ref
                .read(gastoFormProvider(gastoLike).notifier)
                .onImportesChange,
            onPImporteChanged: ref
                .read(gastoFormProvider(gastoLike).notifier)
                .onPimportesChange,
            removeDetalle:
                ref.read(gastoFormProvider(gastoLike).notifier).removeDetalle,
          ),
          /*Fin detalles actualizar*/
          const SizedBox(height: 10),
          Visibility(
            visible: gastoLike.documento!.isNotEmpty &&
                ['F', 'B', 'E', 'R']
                    .contains(gastoLike.documento![0].toUpperCase()),
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            child: Column(children: [
              Center(
                child: CustomFilledButton(
                  onPressed: () async {
                    final responseSunat = await ref
                        .read(gastosProvider.notifier)
                        .validarGastoConSunat(gastoLike);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Resultado de Validación con SUNAT'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('RUC: ${gastoLike.ruc}'),
                                Text(
                                    'Resultado: ${obtenerResultado(responseSunat?.estadoCp ?? 'NOT FOUND')}'),
                                Text(
                                    'Estado: ${obtenerEstado(responseSunat?.estadoRuc ?? 'NOT FOUND')}'),
                                Text(
                                    'Condicion: ${obtenerCondicion(responseSunat?.condDomiRuc ?? 'NOT FOUND')}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  text: "Validar con SUNAT",
                  buttonColor: colors.primary,
                  isLoading: ref.watch(gastosProvider).isLoading,
                  icon: FaIcon(FontAwesomeIcons.squareCheck),
                ),
              ),
              const SizedBox(height: 100),
            ]),
          ),
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

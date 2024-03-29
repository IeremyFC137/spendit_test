import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';
import 'package:spendit_test/features/gastos/presentation/widgets/widgets.dart';
import '../../../shared/shared.dart';
import '../../domain/domain.dart';

class IngresoManualScreen extends StatefulWidget {
  static const name = "ingreso_manual_screen";
  final GastoLike? gastoLike;

  const IngresoManualScreen({super.key, this.gastoLike});

  @override
  State<IngresoManualScreen> createState() => _IngresoManualScreenState();
}

class _IngresoManualScreenState extends State<IngresoManualScreen> {
  late TextEditingController fechaEmisionController;

  @override
  void initState() {
    super.initState();
    fechaEmisionController =
        widget.gastoLike != null && widget.gastoLike?.fechaEmision != null
            ? TextEditingController(
                text: DateFormat('yyyy-MM-dd')
                    .format(widget.gastoLike!.fechaEmision!))
            : TextEditingController(text: '');
  }

  @override
  void dispose() {
    fechaEmisionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
        appBar: AppBarWidget(title: "Registro de gasto"),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: _GastoForm(
                    gastoLike: widget.gastoLike,
                    fechaEmisionController: fechaEmisionController,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _GastoForm extends ConsumerWidget {
  final GastoLike? gastoLike;
  final TextEditingController fechaEmisionController;

  const _GastoForm({
    this.gastoLike,
    required this.fechaEmisionController,
  });

  @override
  Widget build(BuildContext context, ref) {
    final gastoForm = ref.watch(gastoFormProvider(gastoLike));
    final listCcosto = ref.watch(gastosProvider).campoDetalle;
    print(gastoForm);
    print(gastoLike);
    final colors = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Datos Generales",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  width: 8,
                ),
                FaIcon(
                  FontAwesomeIcons.globe,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomGastoField(
              maxLines: 2,
              label: 'Proveedor',
              isTopField: true,
              initialValue: gastoLike?.proveedor ?? "",
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onProveedorChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.proveedor.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Ruc',
              initialValue: gastoLike?.ruc ?? '',
              keyboardType: TextInputType.number,
              isTopField: false,
              onChanged:
                  ref.read(gastoFormProvider(gastoLike).notifier).onRucChange,
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.ruc.errorMessage : null,
            ),
            DividerForm(),
            CustomDropdownFormField<TipoDocumento>(
              maxLines: 2,
              value: parseStringToDocumentType(
                      gastoLike?.tipoDocumento.toString() ?? '') ??
                  gastoForm.tipoDocumento.value,
              items: getTipoDocumentoItems(),
              isTopField: false,
              label: 'Tipo de documento',
              onChanged: (TipoDocumento? newValue) {
                if (newValue != null) {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onTipoDocumentoChange(newValue);
                }
              },
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.tipoDocumento.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomDropdownFormField<Moneda>(
              maxLines: 2,
              value: parseStringToMoneda(gastoLike?.moneda.toString() ?? '') ??
                  gastoForm.moneda.value, // Valor actual del formulario
              isTopField: false,
              items: getMonedaItems(),
              label: 'Tipo de moneda',
              onChanged: (Moneda? newValue) {
                if (newValue != null) {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onMonedaChange(newValue);
                }
              },
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.moneda.errorMessage : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Numero de documento',
              initialValue: gastoLike?.documento ?? '',
              isTopField: false,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onNumeroDocumentoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.numeroDocumento.errorMessage
                  : null,
            ),
            DividerForm(),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  fechaEmisionController.text = formattedDate;
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onFechaEmisionChange(formattedDate);
                }
              },
              child: IgnorePointer(
                child: CustomGastoField(
                  maxLines: 2,
                  label: 'Fecha de emisión',
                  //isTopField: false,
                  keyboardType: TextInputType.datetime,
                  onChanged: (_) {},
                  errorMessage: gastoForm.isFormPosted
                      ? gastoForm.fechaEmision.errorMessage
                      : null,
                  controller: fechaEmisionController,
                ),
              ),
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Sub Total',
              isTopField: false,
              initialValue: gastoLike?.subTotal.toString() ?? '',
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onSubTotalChange(double.parse(value)),
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.subTotal.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'IGV',
              initialValue: gastoLike?.igv.toString() ?? '',
              isBottomField: true,
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onIgvChange(double.parse(value)),
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.igv.errorMessage : null,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Detalles",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  width: 8,
                ),
                FaIcon(
                  FontAwesomeIcons.circleInfo,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElementoAutocompleteWidget(
                label: 'Centro de costo',
                maxLines: 2,
                isTopField: true,
                keyboardType: TextInputType.text,
                elementos: listCcosto,
                errorMessage: gastoForm.isFormPosted
                    ? gastoForm.centroCosto.errorMessage
                    : null,
                validator: (value) {
                  if (!listCcosto.contains(value)) {
                    return 'Selecciona un valor válido de la lista.';
                  }
                  if (value == null) {
                    return 'El campo "Centro de costo" no puede estar en blanco';
                  }
                  return null;
                },
                onChanged: ref
                    .read(gastoFormProvider(gastoLike).notifier)
                    .onCentroCostoChange),
            DividerForm(),
            /*CustomGastoField(
              maxLines: 2,
              label: 'Centro de costo',
              isTopField: true,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onCentroCostoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.centroCosto.errorMessage
                  : null,
            ),
            DividerForm(),*/
            CustomGastoField(
              maxLines: 2,
              label: 'Concepto de gasto',
              isTopField: false,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onConceptoGastoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.conceptoGasto.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Cuenta contable',
              isTopField: false,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(gastoLike).notifier)
                  .onCuentaContableChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.cuentaContable.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Importe',
              isTopField: false,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double? parsedValue = double.tryParse(value);
                if (parsedValue == null) {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onImporteChange(0.0);
                } else {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onImporteChange(parsedValue);
                }
              },
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.importe.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label:
                  "Porcentaje de importe (${(gastoForm.pimporte.value * 100).toStringAsFixed(0)}%)",
              keyboardType: TextInputType.number,
              isBottomField: true,
              onChanged: (value) {
                double? parsedValue = double.tryParse(value);
                if (parsedValue == null) {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onPimporteChange(0.0);
                } else {
                  ref
                      .read(gastoFormProvider(gastoLike).notifier)
                      .onPimporteChange(parsedValue / 100);
                }
              },
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.pimporte.errorMessage
                  : null,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: CustomFilledButton(
                  text: 'Guardar',
                  buttonColor: colors.primary,
                  isLoading: gastoForm.isPosting,
                  onPressed: () async {
                    final isSuccess = await ref
                        .read(gastoFormProvider(gastoLike).notifier)
                        .onFormSubmit();

                    if (isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Gasto registrado correctamente"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 4),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      context.pop(); // Regresa a la pantalla anterior.
                    } else if (gastoForm.isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error al registrar el gasto"),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}

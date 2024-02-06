import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/presentation/providers/gasto_form_provider.dart';
import 'package:spendit_test/features/gastos/presentation/widgets/widgets.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

import '../../../shared/shared.dart';
import '../../domain/domain.dart';

class IngresoManualScreen extends StatelessWidget {
  static const name = "ingreso_manual_screen";
  final Map<String, dynamic>? formData;
  const IngresoManualScreen({super.key, this.formData});

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
                    formData: formData,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _GastoForm extends ConsumerWidget {
  final Map<String, dynamic>? formData;
  const _GastoForm({this.formData});
  @override
  Widget build(BuildContext context, ref) {
    final gastoForm = ref.watch(gastoFormProvider(null));
    print(gastoForm);
    print(formData);
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
              keyboardType: TextInputType.text,
              onChanged:
                  ref.read(gastoFormProvider(null).notifier).onProveedorChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.proveedor.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Ruc',
              keyboardType: TextInputType.text,
              isTopField: false,
              onChanged: ref.read(gastoFormProvider(null).notifier).onRucChange,
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.ruc.errorMessage : null,
            ),
            DividerForm(),
            CustomDropdownFormField<TipoDocumento>(
              maxLines: 2,
              value:
                  gastoForm.tipoDocumento.value, // Valor actual del formulario
              items: getTipoDocumentoItems(),
              isTopField: false,
              label: 'Tipo de documento',
              onChanged: (TipoDocumento? newValue) {
                if (newValue != null) {
                  ref
                      .read(gastoFormProvider(null).notifier)
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
              value: gastoForm.moneda.value, // Valor actual del formulario
              isTopField: false,
              items: getMonedaItems(),
              label: 'Tipo de moneda',
              onChanged: (Moneda? newValue) {
                if (newValue != null) {
                  ref
                      .read(gastoFormProvider(null).notifier)
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
              isTopField: false,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(null).notifier)
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
                  ref
                      .read(gastoFormProvider(null).notifier)
                      .onFechaEmisionChange(formattedDate);
                }
              },
              child: IgnorePointer(
                child: CustomGastoField(
                  maxLines: 2,
                  label: 'Fecha de emisión',
                  //isTopField: false,
                  keyboardType: TextInputType.datetime,
                  onChanged: (_) {}, // La lógica del cambio se maneja en onTap
                  errorMessage: gastoForm.isFormPosted
                      ? gastoForm.fechaEmision.errorMessage
                      : null,
                  controller:
                      TextEditingController(text: gastoForm.fechaEmision.value),
                ),
              ),
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Sub Total',
              isTopField: false,
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider(null).notifier)
                  .onSubTotalChange(double.parse(value)),
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.subTotal.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'IGV',
              isBottomField: true,
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider(null).notifier)
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
            CustomGastoField(
              maxLines: 2,
              label: 'Centro de costo',
              isTopField: true,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(null).notifier)
                  .onCentroCostoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.centroCosto.errorMessage
                  : null,
            ),
            DividerForm(),
            CustomGastoField(
              maxLines: 2,
              label: 'Concepto de gasto',
              isTopField: false,
              keyboardType: TextInputType.text,
              onChanged: ref
                  .read(gastoFormProvider(null).notifier)
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
                  .read(gastoFormProvider(null).notifier)
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
                      .read(gastoFormProvider(null).notifier)
                      .onImporteChange(0.0);
                } else {
                  ref
                      .read(gastoFormProvider(null).notifier)
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
                      .read(gastoFormProvider(null).notifier)
                      .onPimporteChange(0.0);
                } else {
                  ref
                      .read(gastoFormProvider(null).notifier)
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
                  onPressed: gastoForm.isPosting
                      ? null
                      : () async {
                          final isSuccess = await ref
                              .read(gastoFormProvider(null).notifier)
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

List<DropdownMenuItem<TipoDocumento>> getTipoDocumentoItems() {
  return TipoDocumento.values.map((TipoDocumento tipo) {
    return DropdownMenuItem<TipoDocumento>(
      value: tipo,
      child:
          Text(tipo.name), // Usando el getter 'name' en lugar de 'describeEnum'
    );
  }).toList();
}

List<DropdownMenuItem<Moneda>> getMonedaItems() {
  return Moneda.values.map((Moneda tipo) {
    return DropdownMenuItem<Moneda>(
      value: tipo,
      child:
          Text(tipo.name), // Usando el getter 'name' en lugar de 'describeEnum'
    );
  }).toList();
}

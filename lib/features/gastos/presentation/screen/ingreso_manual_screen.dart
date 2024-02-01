import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/presentation/providers/gasto_form_provider.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

import '../../../shared/shared.dart';
import '../../domain/domain.dart';

class IngresoManualScreen extends StatelessWidget {
  static const name = "ingreso_manual_screen";
  const IngresoManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
        appBar: AppBarWidget(title: "Ingreso manual"),
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
                  child: const _GastoForm(),
                ),
              ],
            )),
      ),
    );
  }
}

class _GastoForm extends ConsumerWidget {
  const _GastoForm();
  @override
  Widget build(BuildContext context, ref) {
    final gastoForm = ref.watch(gastoFormProvider);
    final colors = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Datos Generales",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Proveedor",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Proveedor',
              keyboardType: TextInputType.text,
              onChanged: ref.read(gastoFormProvider.notifier).onProveedorChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.proveedor.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Ruc",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Ruc',
              keyboardType: TextInputType.text,
              onChanged: ref.read(gastoFormProvider.notifier).onRucChange,
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.ruc.errorMessage : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Tipo de Documento",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdownFormField<TipoDocumento>(
              value:
                  gastoForm.tipoDocumento.value, // Valor actual del formulario
              items: getTipoDocumentoItems(),
              label: 'Tipo de Documento',
              onChanged: (value) =>
                  ref.read(gastoFormProvider.notifier).onTipoDocumentoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.tipoDocumento.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Moneda",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomDropdownFormField<Moneda>(
              value: gastoForm.moneda.value, // Valor actual del formulario
              items: getMonedaItems(),
              label: 'Tipo de moneda',
              onChanged: (value) =>
                  ref.read(gastoFormProvider.notifier).onMonedaChange,
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.moneda.errorMessage : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "N° Documento",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Numero de documento',
              keyboardType: TextInputType.text,
              onChanged:
                  ref.read(gastoFormProvider.notifier).onNumeroDocumentoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.numeroDocumento.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Fecha de emisión",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                      .read(gastoFormProvider.notifier)
                      .onFechaEmisionChange(formattedDate);
                }
              },
              child: IgnorePointer(
                child: CustomTextFormField(
                  label: 'Fecha de emisión',
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Sub Total",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Sub Total',
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider.notifier)
                  .onSubTotalChange(double.parse(value)),
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.subTotal.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Igv",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'IGV',
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(gastoFormProvider.notifier)
                  .onIgvChange(double.parse(value)),
              errorMessage:
                  gastoForm.isFormPosted ? gastoForm.igv.errorMessage : null,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Detalles",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Centro de costo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Centro de costo',
              keyboardType: TextInputType.text,
              onChanged:
                  ref.read(gastoFormProvider.notifier).onCentroCostoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.centroCosto.errorMessage
                  : null,
            ),
            Text(
              "Concepto de gasto",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Concepto de gasto',
              keyboardType: TextInputType.text,
              onChanged:
                  ref.read(gastoFormProvider.notifier).onConceptoGastoChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.conceptoGasto.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cuenta contable",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Cuenta contable',
              keyboardType: TextInputType.text,
              onChanged:
                  ref.read(gastoFormProvider.notifier).onCuentaContableChange,
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.cuentaContable.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Importe",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Importe',
              keyboardType: TextInputType.number,
              onChanged: (values) => ref
                  .read(gastoFormProvider.notifier)
                  .onImporteChange(double.parse(values)),
              errorMessage: gastoForm.isFormPosted
                  ? gastoForm.importe.errorMessage
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Porcentaje de importe (${(gastoForm.pimporte.value * 100).toStringAsFixed(0)}%)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFormField(
              label: 'Porcentaje de Importe',
              keyboardType: TextInputType.number,
              onChanged: (values) => ref
                  .read(gastoFormProvider.notifier)
                  .onPimporteChange(double.parse(values)),
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
              height: 20,
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
                              .read(gastoFormProvider.notifier)
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
                          } else {
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
              height: 20,
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

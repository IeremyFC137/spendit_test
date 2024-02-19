import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:spendit_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';

import 'package:spendit_test/features/gastos/presentation/providers/gastos_provider.dart';
import '../../../auth/domain/domain.dart';
import '../../../shared/shared.dart';

final gastoFormProvider = StateNotifierProvider.autoDispose
    .family<GastoFormNotifier, GastoFormState, GastoLike?>((ref, gastoLike) {
  final gastoRegistrarCallback =
      ref.watch(gastosProvider.notifier).registrarGasto;
  final gastoActualizarCallback =
      ref.watch(gastosProvider.notifier).editarGasto;
  final user = ref.watch(authProvider).user;
  final listCampoDetalle = ref.read(gastosProvider).campoDetalle;
  return GastoFormNotifier(
      gastoRegistrarCallback: gastoRegistrarCallback,
      gastoActualizarCallback: gastoActualizarCallback,
      user: user,
      listCampoDetalle: listCampoDetalle,
      gastoLike: gastoLike);
});

class GastoFormNotifier extends StateNotifier<GastoFormState> {
  final Function gastoRegistrarCallback;
  final Function gastoActualizarCallback;
  final User? user;
  final List listCampoDetalle;
  GastoFormNotifier(
      {required this.gastoRegistrarCallback,
      required this.user,
      required this.listCampoDetalle,
      GastoLike? gastoLike,
      required this.gastoActualizarCallback})
      : super(GastoFormState(
            id: gastoLike?.id,
            proveedor: Proveedor.dirty(gastoLike?.proveedor ?? ""),
            ruc: Ruc.dirty(gastoLike?.ruc ?? ""),
            tipoDocumento: DocumentType.dirty(
                gastoLike?.tipoDocumento ?? TipoDocumento.BOLETA),
            numeroDocumento: DocumentNumber.dirty(gastoLike?.documento ?? ''),
            fechaEmision: FechaEmision.dirty(DateFormat('yyyy-MM-dd').format(
                        gastoLike?.fechaEmision ?? DateTime(2024, 01, 01))) ==
                    FechaEmision.dirty("2024-01-01")
                ? FechaEmision.dirty('')
                : FechaEmision.dirty(
                    DateFormat('yyyy-MM-dd').format(gastoLike!.fechaEmision!)),
            subTotal: SubTotal.dirty(gastoLike?.subTotal ?? 0.0),
            igv: Igv.dirty(gastoLike?.igv ?? 0.0),
            moneda: MoneyType.dirty(gastoLike?.moneda ?? Moneda.SOLES),
            centroCosto: CentroCosto.dirty(gastoLike?.cCosto ?? ''),
            conceptoGasto: ConceptoGasto.dirty(gastoLike?.cGasto ?? ''),
            cuentaContable: CuentaContable.dirty(gastoLike?.cContable ?? ''),
            importe: Importe.dirty(gastoLike?.importe ?? 0.0),
            pimporte: Pimporte.dirty(
              gastoLike?.pImporte ?? 0.0,
            ),
            images: gastoLike?.images ?? []));

  onProveedorChange(String value) {
    final newProveedor = Proveedor.dirty(value);
    state = state.copyWith(
        proveedor: newProveedor,
        isValid: Formz.validate([
          newProveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onRucChange(String value) {
    final newRuc = Ruc.dirty(value);
    state = state.copyWith(
        ruc: newRuc,
        isValid: Formz.validate([
          state.proveedor,
          newRuc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onTipoDocumentoChange(TipoDocumento value) {
    final newTipoDocumento = DocumentType.dirty(value);
    state = state.copyWith(
        tipoDocumento: newTipoDocumento,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          newTipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onNumeroDocumentoChange(String value) {
    final newNumeroDocumento = DocumentNumber.dirty(value);
    state = state.copyWith(
        numeroDocumento: newNumeroDocumento,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          newNumeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onFechaEmisionChange(String value) {
    final newFechaEmision = FechaEmision.dirty(value);
    state = state.copyWith(
        fechaEmision: newFechaEmision,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          newFechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onSubTotalChange(double value) {
    final newSubTotal = SubTotal.dirty(value);
    state = state.copyWith(
        subTotal: newSubTotal,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          newSubTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onIgvChange(double value) {
    final newIgv = Igv.dirty(value);
    state = state.copyWith(
        igv: newIgv,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          newIgv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onMonedaChange(Moneda value) {
    final newMoneda = MoneyType.dirty(value);
    state = state.copyWith(
        moneda: newMoneda,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          newMoneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onCentroCostoChange(String value) {
    final newCentroCosto = CentroCosto.dirty(value);
    state = state.copyWith(
        centroCosto: newCentroCosto,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          newCentroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onConceptoGastoChange(String value) {
    final newConceptoGasto = ConceptoGasto.dirty(value);
    state = state.copyWith(
        conceptoGasto: newConceptoGasto,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          newConceptoGasto,
          state.cuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onCuentaContableChange(String value) {
    final newCuentaContable = CuentaContable.dirty(value);
    state = state.copyWith(
        cuentaContable: newCuentaContable,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          newCuentaContable,
          state.importe,
          state.pimporte
        ]));
  }

  onImporteChange(double value) {
    final newImporte = Importe.dirty(value);

    state = state.copyWith(
        importe: newImporte,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          newImporte,
          state.pimporte
        ]));
  }

  onPimporteChange(double value) {
    final newPimporte = Pimporte.dirty(value);
    state = state.copyWith(
        pimporte: newPimporte,
        isValid: Formz.validate([
          state.proveedor,
          state.ruc,
          state.tipoDocumento,
          state.numeroDocumento,
          state.fechaEmision,
          state.subTotal,
          state.igv,
          state.moneda,
          state.centroCosto,
          state.conceptoGasto,
          state.cuentaContable,
          state.importe,
          newPimporte
        ]));
  }

  void updateGastoImage(String path) {
    state = state.copyWith(images: [path]);
  }

  Future<bool> onFormActualizarSubmit() async {
    _touchEveryField();

    bool esCentroCostoValido =
        listCampoDetalle.contains(state.centroCosto.value);

    if (!state.isValid || !esCentroCostoValido) return false;
    state = state.copyWith(isPosting: true);

    try {
      var isSuccess = await gastoActualizarCallback(
          state.id,
          state.centroCosto.value,
          state.conceptoGasto.value,
          state.cuentaContable.value,
          state.importe.value,
          state.pimporte.value);
      state = state.copyWith(isPosting: false);
      return isSuccess;
    } catch (e) {
      Exception(e);
      state = state.copyWith(isPosting: false);
      return false;
    }
  }

  Future<bool> onFormSubmit() async {
    _touchEveryField();

    bool esCentroCostoValido =
        listCampoDetalle.contains(state.centroCosto.value);

    if (!state.isValid || !esCentroCostoValido) return false;
    state = state.copyWith(isPosting: true);

    DateTime? fechaEmisionParsed = parseFechaEmision(state.fechaEmision.value);
    if (fechaEmisionParsed == null) {
      print(state.fechaEmision.value);
      print("Fecha de emisión no es válida o está en un formato incorrecto.");
      // Maneja el caso de fecha nula aquí. Podrías establecer isPosting a false y retornar false.
      state = state.copyWith(isPosting: false);
      return false;
    }

    try {
      await gastoRegistrarCallback(
        user?.id, // Asegúrate de manejar el caso en que user sea null.
        state.proveedor.value,
        state.ruc.value,
        state.tipoDocumento.value,
        state.numeroDocumento.value,
        fechaEmisionParsed,
        state.subTotal.value,
        state.igv.value,
        state.importe.value,
        state.pimporte.value,
        state.moneda.value,
        state.centroCosto.value,
        state.conceptoGasto.value,
        state.cuentaContable.value,
      );
      state = state.copyWith(isPosting: false);
      return true; // Registro exitoso.
    } catch (e) {
      print(e);
      state = state.copyWith(isPosting: false);
      return false; // Registro fallido.
    }
  }

  _touchEveryField() {
    final proveedor = Proveedor.dirty(state.proveedor.value);
    final ruc = Ruc.dirty(state.ruc.value);
    final tipoDocumento = DocumentType.dirty(state.tipoDocumento.value);
    final numeroDocumento = DocumentNumber.dirty(state.numeroDocumento.value);
    final fechaEmision = FechaEmision.dirty(state.fechaEmision.value);
    final subTotal = SubTotal.dirty(state.subTotal.value);
    final igv = Igv.dirty(state.igv.value);
    final moneda = MoneyType.dirty(state.moneda.value);
    final centroCosto = CentroCosto.dirty(state.centroCosto.value);
    final conceptoGasto = ConceptoGasto.dirty(state.conceptoGasto.value);
    final cuentaContable = CuentaContable.dirty(state.cuentaContable.value);
    final importe = Importe.dirty(state.importe.value);
    final pimporte = Pimporte.dirty(state.pimporte.value);
    state = state.copyWith(
        isFormPosted: true,
        isValid: Formz.validate([
          proveedor,
          ruc,
          tipoDocumento,
          numeroDocumento,
          fechaEmision,
          subTotal,
          igv,
          moneda,
          centroCosto,
          conceptoGasto,
          cuentaContable,
          importe,
          pimporte,
        ]));
  }
}

class GastoFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final int? id;
  final Proveedor proveedor;
  final Ruc ruc;
  final DocumentType tipoDocumento;
  final DocumentNumber numeroDocumento;
  final FechaEmision fechaEmision;
  final SubTotal subTotal;
  final Igv igv;
  final MoneyType moneda;
  final CentroCosto centroCosto;
  final ConceptoGasto conceptoGasto;
  final CuentaContable cuentaContable;
  final Importe importe;
  final Pimporte pimporte;
  final List<String> images;

  GastoFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.id,
      this.proveedor = const Proveedor.pure(),
      this.ruc = const Ruc.pure(),
      this.tipoDocumento = const DocumentType.pure(),
      this.numeroDocumento = const DocumentNumber.pure(),
      this.fechaEmision = const FechaEmision.pure(),
      this.subTotal = const SubTotal.pure(),
      this.igv = const Igv.pure(),
      this.moneda = const MoneyType.pure(),
      this.centroCosto = const CentroCosto.pure(),
      this.conceptoGasto = const ConceptoGasto.pure(),
      this.cuentaContable = const CuentaContable.pure(),
      this.importe = const Importe.pure(),
      this.pimporte = const Pimporte.pure(),
      this.images = const []});

  GastoFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          int? id,
          Proveedor? proveedor,
          Ruc? ruc,
          DocumentType? tipoDocumento,
          DocumentNumber? numeroDocumento,
          FechaEmision? fechaEmision,
          SubTotal? subTotal,
          Igv? igv,
          MoneyType? moneda,
          CentroCosto? centroCosto,
          ConceptoGasto? conceptoGasto,
          CuentaContable? cuentaContable,
          Importe? importe,
          Pimporte? pimporte,
          List<String>? images}) =>
      GastoFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          id: id ?? this.id,
          proveedor: proveedor ?? this.proveedor,
          ruc: ruc ?? this.ruc,
          tipoDocumento: tipoDocumento ?? this.tipoDocumento,
          numeroDocumento: numeroDocumento ?? this.numeroDocumento,
          fechaEmision: fechaEmision ?? this.fechaEmision,
          subTotal: subTotal ?? this.subTotal,
          igv: igv ?? this.igv,
          moneda: moneda ?? this.moneda,
          centroCosto: centroCosto ?? this.centroCosto,
          conceptoGasto: conceptoGasto ?? this.conceptoGasto,
          cuentaContable: cuentaContable ?? this.cuentaContable,
          importe: importe ?? this.importe,
          pimporte: pimporte ?? this.pimporte,
          images: images ?? this.images);

  @override
  String toString() {
    return '''

      GastoFormState:
      ---------------
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isValid: $isValid
        proveedor: ${proveedor.value}
        ruc: ${ruc.value}
        tipoDocumento: ${tipoDocumento.value}
        numeroDocumento: ${numeroDocumento.value}
        fechaEmision: ${fechaEmision.value}
        subTotal: ${subTotal.value}
        igv: ${igv.value}
        moneda: ${moneda.value}
        centroCosto: ${centroCosto.value}
        conceptoGasto: ${conceptoGasto.value}
        cuentaContable: ${cuentaContable.value}
        importe: ${importe.value}
        pImporte: ${pimporte.value}
    ''';
  }
}

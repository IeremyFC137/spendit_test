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
            fechaEmision: FechaEmision.dirty(DateFormat('yyyy-MM-dd').format(gastoLike?.fechaEmision ?? DateTime(2024, 01, 01))) ==
                    FechaEmision.dirty("2024-01-01")
                ? FechaEmision.dirty('')
                : FechaEmision.dirty(
                    DateFormat('yyyy-MM-dd').format(gastoLike!.fechaEmision!)),
            subTotal: SubTotal.dirty(gastoLike?.subTotal ?? 0.0),
            igv: Igv.dirty(gastoLike?.igv ?? 0.0),
            moneda: MoneyType.dirty(gastoLike?.moneda ?? Moneda.SOLES),
            centrosCosto: gastoLike?.detalles
                    ?.map((d) => CentroCosto.dirty(d.cCosto))
                    .toList() ??
                [CentroCosto.pure()],
            conceptosGasto: gastoLike?.detalles
                    ?.map((d) => ConceptoGasto.dirty(d.cGasto))
                    .toList() ??
                [ConceptoGasto.pure()],
            cuentasContables: gastoLike?.detalles
                    ?.map((d) => CuentaContable.dirty(d.cContable))
                    .toList() ??
                [CuentaContable.pure()],
            importes: gastoLike?.detalles?.map((d) => Importe.dirty(d.importe)).toList() ?? [Importe.pure()],
            pimportes: gastoLike?.detalles?.map((d) => Pimporte.dirty(d.pImporte)).toList() ?? [Pimporte.pure()],
            images: gastoLike?.images ?? []));

  void addDetalle() {
    state = state.copyWith(
      centrosCosto: List.from(state.centrosCosto)..add(CentroCosto.pure()),
      conceptosGasto: List.from(state.conceptosGasto)
        ..add(ConceptoGasto.pure()),
      cuentasContables: List.from(state.cuentasContables)
        ..add(CuentaContable.pure()),
      importes: List.from(state.importes)..add(Importe.pure()),
      pimportes: List.from(state.pimportes)..add(Pimporte.pure()),
    );
  }

  void removeDetalle(int index) {
    if (state.centrosCosto.length > 1) {
      state = state.copyWith(
        centrosCosto: List.from(state.centrosCosto)..removeAt(index),
        conceptosGasto: List.from(state.conceptosGasto)..removeAt(index),
        cuentasContables: List.from(state.cuentasContables)..removeAt(index),
        importes: List.from(state.importes)..removeAt(index),
        pimportes: List.from(state.pimportes)..removeAt(index),
      );
    }
  }

  void onProveedorChange(String value) {
    final newProveedor = Proveedor.dirty(value);

    final isValid = Formz.validate([
      newProveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...state.centrosCosto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...state.importes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      proveedor: newProveedor,
      isValid: isValid,
    );
  }

  void onRucChange(String value) {
    final newRuc = Ruc.dirty(value);

    final isValid = Formz.validate([
      state.proveedor,
      newRuc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...state.centrosCosto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...state.importes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      ruc: newRuc,
      isValid: isValid,
    );
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
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
          ...state.centrosCosto,
          ...state.conceptosGasto,
          ...state.cuentasContables,
          ...state.importes,
          ...state.pimportes,
        ]));
  }

  void onCentrosCostoChange(int index, String value) {
    final List<CentroCosto> updatedCentrosCosto =
        List<CentroCosto>.from(state.centrosCosto);
    updatedCentrosCosto[index] = CentroCosto.dirty(value);
    final isValid = Formz.validate([
      state.proveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...updatedCentrosCosto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...state.importes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      centrosCosto: updatedCentrosCosto,
      isValid: isValid,
    );
  }

  onConceptosGastoChange(int index, String value) {
    final List<ConceptoGasto> updatedConceptosGasto =
        List<ConceptoGasto>.from(state.conceptosGasto);
    updatedConceptosGasto[index] = ConceptoGasto.dirty(value);
    final isValid = Formz.validate([
      state.proveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...updatedConceptosGasto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...state.importes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      conceptosGasto: updatedConceptosGasto,
      isValid: isValid,
    );
  }

  onCuentasContableChange(int index, String value) {
    final List<CuentaContable> updatedCuentasContable =
        List<CuentaContable>.from(state.cuentasContables);
    updatedCuentasContable[index] = CuentaContable.dirty(value);

    final isValid = Formz.validate([
      state.proveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...updatedCuentasContable,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...state.importes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      cuentasContables: updatedCuentasContable,
      isValid: isValid,
    );
  }

  void onImportesChange(int index, double value) {
    final List<Importe> updatedImportes = List<Importe>.from(state.importes);
    updatedImportes[index] = Importe.dirty(value);

    final isValid = Formz.validate([
      state.proveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...state.centrosCosto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...updatedImportes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      importes: updatedImportes,
      isValid: isValid,
    );
  }

  onPimportesChange(int index, double value) {
    final List<Pimporte> updatedPimportes =
        List<Pimporte>.from(state.pimportes);
    updatedPimportes[index] = Pimporte.dirty(value);

    final isValid = Formz.validate([
      state.proveedor,
      state.ruc,
      state.tipoDocumento,
      state.numeroDocumento,
      state.fechaEmision,
      state.subTotal,
      state.igv,
      state.moneda,
      ...state.centrosCosto,
      ...state.conceptosGasto,
      ...state.cuentasContables,
      ...updatedPimportes,
      ...state.pimportes,
    ]);

    state = state.copyWith(
      pimportes: updatedPimportes,
      isValid: isValid,
    );
  }

  void updateGastoImage(String path) {
    state = state.copyWith(images: [path]);
  }

  Future<bool> onFormActualizarSubmit(List<int> ids) async {
    _touchEveryField();

    if (!state.isValid) return false;

    state = state.copyWith(isPosting: true);

    List<DetallesGasto> detallesActualizados = List.generate(
      state.centrosCosto.length,
      (index) => DetallesGasto(
        id: ids[index],
        cCosto: state.centrosCosto[index].value,
        cGasto: state.conceptosGasto[index].value,
        cContable: state.cuentasContables[index].value,
        importe: state.importes[index].value,
        pImporte: state.pimportes[index].value,
      ),
    );

    try {
      if (state.id == null) {
        print("ID del gasto es nulo, no se puede actualizar.");
        state = state.copyWith(isPosting: false);
        return false;
      }

      bool isSuccess = await gastoActualizarCallback(
        state.id!,
        detallesActualizados,
      );

      state = state.copyWith(isPosting: false);
      return isSuccess;
    } catch (e) {
      print(e);
      state = state.copyWith(isPosting: false);
      return false;
    }
  }

  Future<bool> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) {
      return false;
    }

    state = state.copyWith(isPosting: true);

    DateTime? fechaEmisionParsed = parseFechaEmision(state.fechaEmision.value);
    if (fechaEmisionParsed == null) {
      print("Fecha de emisión no es válida o está en un formato incorrecto.");
      state = state.copyWith(isPosting: false);
      return false;
    }

    List<DetallesGasto> detalles = List.generate(
        state.centrosCosto.length,
        (index) => DetallesGasto(
              id: 0,
              cCosto: state.centrosCosto[index].value,
              cGasto: state.conceptosGasto[index].value,
              cContable: state.cuentasContables[index].value,
              importe: state.importes[index].value,
              pImporte: state.pimportes[index].value,
            ));

    try {
      await gastoRegistrarCallback(
        user?.id ?? 0,
        state.proveedor.value,
        state.ruc.value,
        state.tipoDocumento.value,
        state.numeroDocumento.value,
        fechaEmisionParsed,
        state.subTotal.value,
        state.igv.value,
        state.moneda.value,
        detalles,
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

    final centrosCosto =
        state.centrosCosto.map((c) => CentroCosto.dirty(c.value)).toList();
    final conceptosGasto =
        state.conceptosGasto.map((c) => ConceptoGasto.dirty(c.value)).toList();
    final cuentasContables = state.cuentasContables
        .map((c) => CuentaContable.dirty(c.value))
        .toList();
    final importes = state.importes.map((i) => Importe.dirty(i.value)).toList();
    final pimportes =
        state.pimportes.map((p) => Pimporte.dirty(p.value)).toList();

    state = state.copyWith(
      centrosCosto: centrosCosto,
      conceptosGasto: conceptosGasto,
      cuentasContables: cuentasContables,
      importes: importes,
      pimportes: pimportes,
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
        ...centrosCosto,
        ...conceptosGasto,
        ...cuentasContables,
        ...importes,
        ...pimportes,
      ]),
    );
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
  final List<CentroCosto> centrosCosto;
  final List<ConceptoGasto> conceptosGasto;
  final List<CuentaContable> cuentasContables;
  final List<Importe> importes;
  final List<Pimporte> pimportes;
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
      this.centrosCosto = const [CentroCosto.pure()],
      this.conceptosGasto = const [ConceptoGasto.pure()],
      this.cuentasContables = const [CuentaContable.pure()],
      this.importes = const [Importe.pure()],
      this.pimportes = const [Pimporte.pure()],
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
          List<CentroCosto>? centrosCosto,
          List<ConceptoGasto>? conceptosGasto,
          List<CuentaContable>? cuentasContables,
          List<Importe>? importes,
          List<Pimporte>? pimportes,
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
          centrosCosto: centrosCosto ?? this.centrosCosto,
          conceptosGasto: conceptosGasto ?? this.conceptosGasto,
          cuentasContables: cuentasContables ?? this.cuentasContables,
          importes: importes ?? this.importes,
          pimportes: pimportes ?? this.pimportes,
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
        centroCosto: ${centrosCosto.map((e) => "${e.value}")}
        conceptoGasto: ${conceptosGasto.map((e) => "${e.value}")}
        cuentaContable: ${cuentasContables.map((e) => "${e.value}")}
        importe: ${importes.map((e) => "${e.value}")}
        pImporte: ${pimportes.map((e) => "${e.value}")}
    ''';
  }
}

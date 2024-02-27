import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'gastos_repository_provider.dart';

final gastosProvider =
    StateNotifierProvider<GastosNotifier, GastosState>((ref) {
  final gastosRepository = ref.watch(gastosRepositoryProvider);

  return GastosNotifier(
    gastosRepository: gastosRepository,
  );
});

class GastosNotifier extends StateNotifier<GastosState> {
  final GastosRepository gastosRepository;

  GastosNotifier({required this.gastosRepository}) : super(GastosState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final gastos =
        await gastosRepository.listarGastos(size: state.size, page: state.page);
    if (gastos.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }
    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        page: gastos.isEmpty ? state.page : state.page + 1,
        gastos: [...state.gastos, ...gastos]);
  }

  Future<bool> editarGasto(int gastoId,
      List<DetallesGasto> detallesActualizados, List<int>? idsEliminar) async {
    try {
      final Gasto gastoActualizado = await gastosRepository.editarGasto(
          gastoId: gastoId,
          detalles: detallesActualizados,
          idsEliminar: idsEliminar);

      final int index = state.gastos.indexWhere((gasto) => gasto.id == gastoId);
      if (index != -1) {
        final List<Gasto> updatedGastos = List<Gasto>.from(state.gastos);
        updatedGastos[index] = gastoActualizado;

        state = state.copyWith(gastos: updatedGastos);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> registrarGasto(
      int idUsuario,
      String proveedor,
      String ruc,
      TipoDocumento tipoDocumento,
      String documento,
      DateTime fechaEmision,
      double subTotal,
      double igv,
      Moneda moneda,
      List<DetallesGasto> detalles) async {
    try {
      state = state.copyWith(isLoading: true);
      final gasto = await gastosRepository.registrarGasto(
        idUsuario: idUsuario,
        proveedor: proveedor,
        ruc: ruc,
        tipoDocumento: tipoDocumento,
        documento: documento,
        fecha_emision: fechaEmision,
        subTotal: subTotal,
        igv: igv,
        moneda: moneda,
        detalles: detalles,
      );
      state =
          state.copyWith(gastos: [...state.gastos, gasto], isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e); // Considera manejar este error de forma más adecuada
    }
  }

  Future<GastoLike?> enviarImagen(File imagen) async {
    state = state.copyWith(isLoading: true);
    try {
      final gastoLike = await gastosRepository.enviarImagen(imagen);
      state = state.copyWith(isLoading: false);
      return gastoLike;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e);
      return null; // Devuelve null si hay una excepción
    }
  }

  Future<ConsultaSunat?> validarGastoConSunat(GastoLike gasto) async {
    state = state.copyWith(isLoading: true);
    try {
      final sunatResponse = await gastosRepository.validarGastoConSunat(gasto);
      state = state.copyWith(isLoading: false);
      return sunatResponse;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e);
      throw Exception(e);
    }
  }

  Future<void> eliminarGasto(int gastoId) async {
    try {
      await gastosRepository.eliminarGasto(gastoId);
      state = state.copyWith(
          gastos: state.gastos.where((gasto) => gasto.id != gastoId).toList());
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> eliminarDetalleGasto(int detalleId) async {
    try {
      await gastosRepository.eliminarDetalleGasto(detalleId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> obtenerCampoDetalle() async {
    if (state.hasCgastoBeenObtained == true) {
      return;
    }
    try {
      final listaCentroCosto = await gastosRepository.obtenerCampoDetalle();
      state = state.copyWith(
          hasCgastoBeenObtained: true, campoDetalle: [...listaCentroCosto]);
    } catch (e) {
      state = state.copyWith(hasCgastoBeenObtained: false);
      print(e);
      throw Exception(e);
    }
  }
}

class GastosState {
  final bool isLastPage;
  final int size;
  final int page;
  final bool isLoading;
  final bool hasCgastoBeenObtained;
  final List<String> campoDetalle;
  final List<Gasto> gastos;

  GastosState(
      {this.isLastPage = false,
      this.size = 7,
      this.page = 0,
      this.isLoading = false,
      this.hasCgastoBeenObtained = false,
      this.gastos = const [],
      this.campoDetalle = const []});

  GastosState copyWith(
          {bool? isLastPage,
          int? size,
          int? page,
          bool? isLoading,
          bool? hasCgastoBeenObtained,
          List<Gasto>? gastos,
          List<String>? campoDetalle}) =>
      GastosState(
          isLastPage: isLastPage ?? this.isLastPage,
          size: size ?? this.size,
          page: page ?? this.page,
          isLoading: isLoading ?? this.isLoading,
          gastos: gastos ?? this.gastos,
          campoDetalle: campoDetalle ?? this.campoDetalle,
          hasCgastoBeenObtained:
              hasCgastoBeenObtained ?? this.hasCgastoBeenObtained);
}

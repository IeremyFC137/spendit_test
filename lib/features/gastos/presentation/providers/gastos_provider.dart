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

  Future<bool> editarGasto(int gastoId, String? cCosto, String? cGasto,
      String? cContable, double importe, double pImporte) async {
    try {
      var aux =
          state.gastos.where((element) => element.id == gastoId).toList()[0];
      if (aux.cCosto == cCosto) {
        cCosto = null;
      }
      if (aux.cGasto == cGasto) {
        cGasto = null;
      }
      if (aux.cContable == cContable) {
        cContable = null;
      }
      if (aux.importe == importe) {
        importe = 0.0;
      }
      if (aux.pImporte == pImporte) {
        pImporte = 2.0;
      }
      final gasto = await gastosRepository.editarGasto(
          gastoId: gastoId,
          cContable: cContable,
          cCosto: cCosto,
          cGasto: cGasto,
          importe: importe,
          pImporte: pImporte);
      state = state.copyWith(
          gastos: state.gastos
              .map(
                (element) => (element.id == gasto.id) ? gasto : element,
              )
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> registrarGasto(
      int idUsuario,
      String proveedor,
      String ruc,
      TipoDocumento tipoDocumento,
      String documento,
      DateTime fecha_emision,
      double subTotal,
      double igv,
      double importe,
      double pImporte,
      Moneda moneda,
      String cCosto,
      String cGasto,
      String cContable) async {
    try {
      state = state.copyWith(isLoading: true);
      final gasto = await gastosRepository.registrarGasto(
          idUsuario: idUsuario,
          proveedor: proveedor,
          ruc: ruc,
          tipoDocumento: tipoDocumento,
          documento: documento,
          fecha_emision: fecha_emision,
          subTotal: subTotal,
          igv: igv,
          importe: importe,
          pImporte: pImporte,
          moneda: moneda,
          cCosto: cCosto,
          cGasto: cGasto,
          cContable: cContable);
      state =
          state.copyWith(gastos: [...state.gastos, gasto], isLoading: false);
    } catch (e) {
      state.copyWith(isLoading: false);
      print(e);
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
}

class GastosState {
  final bool isLastPage;
  final int size;
  final int page;
  final bool isLoading;
  final List<Gasto> gastos;

  GastosState(
      {this.isLastPage = false,
      this.size = 7,
      this.page = 0,
      this.isLoading = false,
      this.gastos = const []});

  GastosState copyWith({
    bool? isLastPage,
    int? size,
    int? page,
    bool? isLoading,
    List<Gasto>? gastos,
  }) =>
      GastosState(
          isLastPage: isLastPage ?? this.isLastPage,
          size: size ?? this.size,
          page: page ?? this.page,
          isLoading: isLoading ?? this.isLoading,
          gastos: gastos ?? this.gastos);
}

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

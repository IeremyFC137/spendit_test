import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';

final gastoProvider = StateNotifierProvider.autoDispose
    .family<GastoNotifier, GastoState, int>((ref, gastoId) {
  final gastosRepository = ref.watch(gastosRepositoryProvider);

  return GastoNotifier(gastosRepository: gastosRepository, gastoId: gastoId);
});

class GastoNotifier extends StateNotifier<GastoState> {
  final GastosRepository gastosRepository;

  GastoNotifier({required this.gastosRepository, required int gastoId})
      : super(GastoState(id: gastoId)) {
    loadGasto();
  }

  Future<void> loadGasto() async {
    try {
      final gasto = await gastosRepository.getGastoById(state.id);
      print(gasto.proveedor);
      state = state.copyWith(isLoading: false, gasto: gasto);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}

class GastoState {
  final int id;
  final Gasto? gasto;
  final bool isLoading;
  final bool isSaving;

  GastoState(
      {required this.id,
      this.gasto,
      this.isLoading = true,
      this.isSaving = false});

  GastoState copyWith({
    int? id,
    Gasto? gasto,
    bool? isLoading,
    bool? isSaving,
  }) =>
      GastoState(
          id: id ?? this.id,
          gasto: gasto ?? this.gasto,
          isLoading: isLoading ?? this.isLoading,
          isSaving: isSaving ?? this.isSaving);
}

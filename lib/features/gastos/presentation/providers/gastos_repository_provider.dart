import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendit_test/features/auth/presentation/providers/providers.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';

final gastosRepositoryProvider = Provider<GastosRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final gastosRepository =
      GastosRepositoryImpl(GastosDatasourceImpl(accessToken: accessToken));

  return gastosRepository;
});

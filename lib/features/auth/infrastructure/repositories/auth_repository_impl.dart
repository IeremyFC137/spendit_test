import 'package:spendit_test/features/auth/domain/entities/user.dart';
import 'package:spendit_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:spendit_test/features/auth/infrastructure/infrastructure.dart';

import '../../domain/datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }
  /*
  @override<User> register(String email, String password, String fullName){
    return dataSource.register(email, password, fullName);
  }
   */
}

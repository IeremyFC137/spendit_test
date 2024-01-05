import 'package:spendit_test/features/auth/domain/datasources/auth_datasource.dart';
import 'package:spendit_test/features/auth/domain/entities/user.dart';

class AuthDatasourceImp extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}

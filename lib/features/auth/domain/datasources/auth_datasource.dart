import '../entities/user.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  //Future<User> register(String email, String password, String fullname);
  Future<User> checkAuthStatus(String token);
}

class User {
  final int id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.roles,
      required this.token});

  bool get isSupervisor {
    return roles.contains('supervisor');
  }
}

class Auth {
  final String phone;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final DateTime createdAt;

  const Auth({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.createdAt,
  });
}

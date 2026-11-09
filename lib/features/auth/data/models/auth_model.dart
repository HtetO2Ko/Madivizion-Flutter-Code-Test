import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.phone,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      phone: map['phone'] as String,
      firstName: map['first_name'] as String,
      lastName: (map['last_name'] as String?) ?? '',
      dateOfBirth: DateTime.parse(map['date_of_birth'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

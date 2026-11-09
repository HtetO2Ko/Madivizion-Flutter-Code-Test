import 'package:equatable/equatable.dart';

class DateOfBirthState extends Equatable {
  final DateTime? dateOfBirth;
  final String? errorMessage;

  const DateOfBirthState({this.dateOfBirth, this.errorMessage});

  bool get isValid => dateOfBirth != null && errorMessage == null;

  @override
  List<Object?> get props => [dateOfBirth, errorMessage];
}

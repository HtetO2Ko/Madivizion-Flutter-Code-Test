import 'package:equatable/equatable.dart';

import '../../../domain/validators/name_validator.dart';

class NameState extends Equatable {
  final String firstName;
  final String lastName;

  const NameState({this.firstName = '', this.lastName = ''});

  bool get isFirstNameValid => NameValidator.isValidFirstName(firstName);

  bool get isLastNameValid => NameValidator.isValidLastName(lastName);

  bool get isValid {
    if (!isFirstNameValid) return false;
    if (NameValidator.isMyanmarOnlyName(firstName)) {
      return isLastNameValid;
    }
    return lastName.trim().isNotEmpty && isLastNameValid;
  }

  @override
  List<Object?> get props => [firstName, lastName];

  NameState copyWith({String? firstName, String? lastName}) {
    return NameState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}

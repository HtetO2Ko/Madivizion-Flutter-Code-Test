import 'package:equatable/equatable.dart';

abstract class DateOfBirthEvent extends Equatable {
  const DateOfBirthEvent();

  @override
  List<Object?> get props => [];
}

class DateOfBirthSelected extends DateOfBirthEvent {
  final DateTime date;

  const DateOfBirthSelected(this.date);

  @override
  List<Object?> get props => [date];
}

class DateOfBirthSubmitted extends DateOfBirthEvent {
  const DateOfBirthSubmitted({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  final String phoneNumber;
  final String firstName;
  final String lastName;
}

class DateOfBirthLoadingStarted extends DateOfBirthEvent {}

class DateOfBirthLoadingFinished extends DateOfBirthEvent {}

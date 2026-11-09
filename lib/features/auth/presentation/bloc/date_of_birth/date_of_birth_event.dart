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

import 'package:equatable/equatable.dart';

abstract class NameEvent extends Equatable {
  const NameEvent();

  @override
  List<Object?> get props => [];
}

class FirstNameChanged extends NameEvent {
  final String value;

  const FirstNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class LastNameChanged extends NameEvent {
  final String value;

  const LastNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

import 'package:equatable/equatable.dart';

class PhoneNumberContinuePressed extends PhoneNumberEvent {}

abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object?> get props => [];
}

class PhoneNumberChanged extends PhoneNumberEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneNumberFocusLost extends PhoneNumberEvent {
  const PhoneNumberFocusLost();
}

import 'package:equatable/equatable.dart';

class PhoneNumberState extends Equatable {
  final String phoneNumber;
  final bool isValid;
  final bool showError;
  final bool isLoading;

  const PhoneNumberState({
    this.phoneNumber = '',
    this.isValid = false,
    this.showError = false,
    this.isLoading = false,
  });

  String get normalizedPhone {
    var phone = phoneNumber.replaceAll(RegExp(r'[\s-]'), '');

    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    return phone;
  }

  PhoneNumberState copyWith({
    String? phoneNumber,
    bool? isValid,
    bool? showError,
    bool? isLoading,
  }) {
    return PhoneNumberState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
      showError: showError ?? this.showError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, isValid, showError];
}

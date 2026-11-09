import 'package:flutter_bloc/flutter_bloc.dart';

import 'phone_number_event.dart';
import 'phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc() : super(const PhoneNumberState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberFocusLost>(_onPhoneNumberFocusLost);
    on<PhoneNumberContinuePressed>(_onContinuePressed);
  }

  Future<void> _onContinuePressed(
    PhoneNumberContinuePressed event,
    Emitter<PhoneNumberState> emit,
  ) async {
    // Prevent multiple submissions.
    if (state.isLoading || !state.isValid) return;

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false));
  }

  String _normalizePhone(String value) {
    var phone = value.replaceAll(RegExp(r'[\s-]'), '');

    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    return phone;
  }

  bool _isValidPhone(String value) {
    final phone = _normalizePhone(value);

    return RegExp(r'^9\d{7,9}$').hasMatch(phone);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PhoneNumberState> emit,
  ) {
    final isValid = _isValidPhone(event.phoneNumber);

    emit(
      state.copyWith(
        phoneNumber: event.phoneNumber,
        isValid: isValid,
        showError: false,
      ),
    );
  }

  void _onPhoneNumberFocusLost(
    PhoneNumberFocusLost event,
    Emitter<PhoneNumberState> emit,
  ) {
    emit(state.copyWith(showError: true));
  }
}

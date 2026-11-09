import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;

  OtpBloc() : super(const OtpState()) {
    on<OtpChanged>(_onOtpChanged);
    on<OtpTimerTicked>(_onTimerTicked);
    on<OtpResendRequested>(_onResendRequested);

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) {
        add(const OtpTimerTicked());
      }
    });
  }

  void _onTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    if (state.remainingSeconds <= 0) {
      _timer?.cancel();
      return;
    }

    emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));

    if (state.remainingSeconds == 0) {
      _timer?.cancel();
    }
  }

  Future<void> _onOtpChanged(OtpChanged event, Emitter<OtpState> emit) async {
    if (!state.canEnterOtp) return;

    final otp = event.otp;

    emit(state.copyWith(otp: otp, clearError: true));

    if (otp.length != 6) return;

    emit(state.copyWith(isVerifying: true, clearError: true));

    // Temporary local mock verification.
    await Future.delayed(const Duration(milliseconds: 500));

    if (emit.isDone) return;

    if (otp == '123456') {
      emit(
        state.copyWith(isVerifying: false, isVerified: true, clearError: true),
      );
    } else {
      final attempts = state.wrongAttempts + 1;

      emit(
        state.copyWith(
          otp: '',
          wrongAttempts: attempts,
          isVerifying: false,
          errorMessage: attempts >= 3
              ? 'Too many incorrect attempts. Please wait until you can resend OTP.'
              : 'Incorrect OTP. Please try again.',
        ),
      );
    }
  }

  void _onResendRequested(OtpResendRequested event, Emitter<OtpState> emit) {
    if (!state.canResend || state.isVerified) return;

    emit(
      state.copyWith(
        otp: '',
        remainingSeconds: 300,
        wrongAttempts: 0,
        isVerifying: false,
        isVerified: false,
        clearError: true,
      ),
    );

    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String otp;
  final int remainingSeconds;
  final int wrongAttempts;
  final bool isVerifying;
  final bool isVerified;
  final String? errorMessage;

  const OtpState({
    this.otp = '',
    this.remainingSeconds = 300,
    this.wrongAttempts = 0,
    this.isVerifying = false,
    this.isVerified = false,
    this.errorMessage,
  });

  bool get isOtpValid => otp.length == 6;

  bool get isLocked => wrongAttempts >= 3;

  bool get canResend => remainingSeconds == 0;

  bool get canEnterOtp => !isVerifying && !isVerified && !isLocked;

  String get formattedTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');

    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  OtpState copyWith({
    String? otp,
    int? remainingSeconds,
    int? wrongAttempts,
    bool? isVerifying,
    bool? isVerified,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      wrongAttempts: wrongAttempts ?? this.wrongAttempts,
      isVerifying: isVerifying ?? this.isVerifying,
      isVerified: isVerified ?? this.isVerified,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    otp,
    remainingSeconds,
    wrongAttempts,
    isVerifying,
    isVerified,
    errorMessage,
  ];
}

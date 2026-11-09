import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/otp/otp_bloc.dart';
import '../bloc/otp/otp_event.dart';
import '../bloc/otp/otp_state.dart';

class OtpForm extends StatefulWidget {
  final ValueChanged<String> onVerified;
  final VoidCallback onResend;

  const OtpForm({super.key, required this.onVerified, required this.onResend});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value) {
    context.read<OtpBloc>().add(OtpChanged(value));
  }

  void _resendOtp() {
    final state = context.read<OtpBloc>().state;

    if (!state.canResend) return;

    context.read<OtpBloc>().add(const OtpResendRequested());

    _controller.clear();
    widget.onResend();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listenWhen: (previous, current) =>
          previous.isVerified != current.isVerified ||
          previous.otp != current.otp,
      listener: (context, state) {
        if (state.isVerified) {
          _focusNode.unfocus();
          widget.onVerified(state.otp);
        } else if (state.otp.isEmpty && _controller.text.isNotEmpty) {
          _controller.clear();

          if (!state.isLocked) {
            _focusNode.requestFocus();
          }
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOtpBoxes(state),

            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage!,
                style: const TextStyle(color: AppColors.error, fontSize: 13),
              ),
            ],

            if (state.isVerifying) ...[
              const SizedBox(height: 16),
              const LinearProgressIndicator(color: AppColors.primary),
            ],

            const SizedBox(height: 28),

            const Text(
              "Didn't receive the code?",
              style: TextStyle(fontSize: 15, color: AppColors.textPrimary),
            ),

            const SizedBox(height: 6),

            if (!state.canResend) ...[
              Row(
                children: [
                  const Text(
                    'resend in ',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${state.formattedTime} min',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ] else
              TextButton(
                onPressed: _resendOtp,
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildOtpBoxes(OtpState state) {
    return SizedBox(
      height: 84,
      child: GestureDetector(
        onTap: () {
          if (state.canEnterOtp) {
            _focusNode.requestFocus();
          }
        },
        child: Stack(
          children: [
            ListenableBuilder(
              listenable: _focusNode,
              builder: (context, child) {
                return Row(
                  children: List.generate(6, (index) {
                    final hasValue = index < state.otp.length;
                    final isCurrent = index == state.otp.length;

                    return Expanded(
                      child: Container(
                        height: 84,
                        margin: EdgeInsets.only(right: index == 5 ? 0 : 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _focusNode.hasFocus && isCurrent
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          hasValue ? state.otp[index] : '',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  enabled: state.canEnterOtp,
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChanged: _onOtpChanged,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

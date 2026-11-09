import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/phone/phone_number_bloc.dart';
import '../bloc/phone/phone_number_event.dart';
import '../bloc/phone/phone_number_state.dart';

class PhoneNumberForm extends StatefulWidget {
  final ValueChanged<String> onContinue;

  const PhoneNumberForm({super.key, required this.onContinue});

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
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

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      context.read<PhoneNumberBloc>().add(const PhoneNumberFocusLost());
    }
  }

  void _onPhoneChanged(String value) {
    context.read<PhoneNumberBloc>().add(PhoneNumberChanged(value));
  }

  void _continue(PhoneNumberState state) {
    if (!state.isValid) return;

    widget.onContinue('+95${state.normalizedPhone}');
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
      builder: (context, state) {
        final showError =
            state.showError && state.phoneNumber.isNotEmpty && !state.isValid;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 104,
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: showError ? AppColors.error : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '+95',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(width: 28),

                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                          ],
                          onChanged: _onPhoneChanged,
                          style: const TextStyle(
                            fontSize: 22,
                            color: AppColors.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Phone number',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (showError) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Please enter a valid phone number.',
                    style: TextStyle(color: AppColors.error, fontSize: 12),
                  ),
                ],
              ],
            ),

            SizedBox(
              height: 76,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isValid ? () => _continue(state) : null,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.disabled,
                ),
                child: const Text('CONTINUE'),
              ),
            ),
          ],
        );
      },
    );
  }
}

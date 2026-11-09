import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/storage/session_storage.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../injection_container.dart';
import '../../domain/repositories/auth_repository.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/otp_form.dart';
import '../bloc/otp/otp_bloc.dart';
import '../widgets/terms_container.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  Future<void> _handleOtpVerified(BuildContext context) async {
    try {
      final authRepository = getIt<AuthRepository>();

      final user = await authRepository.getUserByPhone(phoneNumber);

      if (!context.mounted) return;

      if (user != null) {
        await SessionStorage.savePhoneNumber(phoneNumber);

        if (!context.mounted) return;

        context.goNamed(AppRouteNames.tabbar);
      } else {
        context.pushReplacementNamed(
          AppRouteNames.name,
          queryParameters: {'phone': phoneNumber},
        );
      }
    } catch (e) {
      debugPrint('OTP user lookup failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: AuthBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(currentStep: 2, onBack: () => context.pop()),
                    const SizedBox(height: 48),
                    const Text(
                      'Verify your number',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "We've sent 6 digit OTP to $phoneNumber",
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: 48),
                    OtpForm(
                      onVerified: (otp) {
                        _handleOtpVerified(context);
                      },
                      onResend: () {
                        debugPrint('Resend OTP requested');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: TermsContainer(),
        ),
      ),
    );
  }
}

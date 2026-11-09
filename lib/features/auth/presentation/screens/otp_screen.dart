import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/terms_and_service.dart';
import '../models/auth_flow.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/otp_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/otp/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final AuthFlow flow;

  const OtpScreen({super.key, required this.phoneNumber, required this.flow});

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
                        if (flow == AuthFlow.register) {
                          context.pushReplacementNamed(
                            AppRouteNames.name,
                            queryParameters: {'phone': phoneNumber},
                          );
                        } else {
                          debugPrint("Go To Home");
                          // context.goNamed(AppRouteNames.home);
                        }
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
          bottomNavigationBar: const SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: TermsAndService(),
            ),
          ),
        ),
      ),
    );
  }
}

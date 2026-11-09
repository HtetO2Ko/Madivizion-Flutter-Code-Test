import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/terms_and_service.dart';
import '../bloc/phone/phone_number_bloc.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/phone_number_form.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneNumberBloc(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: AuthBackground(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthHeader(
                                currentStep: 1,
                                onBack: () => context.pop(),
                              ),

                              const SizedBox(height: 48),

                              const Text(
                                'Enter your phone\nnumber',
                                style: AppTextStyles.heading,
                              ),

                              const SizedBox(height: 40),

                              Expanded(
                                child: PhoneNumberForm(
                                  onContinue: (phoneNumber) {
                                    context.pushNamed(
                                      AppRouteNames.otp,
                                      queryParameters: {'phone': phoneNumber},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/terms_and_service.dart';
import '../bloc/name/name_bloc.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/name_form.dart';

class NameScreen extends StatelessWidget {
  final String phoneNumber;
  final String? firstName;
  final String? lastName;

  const NameScreen({
    super.key,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final initialFirstName = firstName ?? '';
    final initialLastName = lastName ?? '';

    return BlocProvider(
      create: (_) =>
          NameBloc(firstName: initialFirstName, lastName: initialLastName),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: AuthBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      currentStep: 3,
                      onBack: () {
                        context.pop();
                        // context.goNamed(
                        //   AppRouteNames.phoneNumber,
                        //   pathParameters: {'flow': 'register'},
                        // );
                      },
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'What is your\nname?',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: NameForm(
                        firstName: initialFirstName,
                        lastName: initialLastName,
                        onContinue: (firstName, lastName) {
                          FocusManager.instance.primaryFocus?.unfocus();

                          context.pushNamed(
                            AppRouteNames.dateOfBirth,
                            queryParameters: {
                              'phone': phoneNumber,
                              'firstName': firstName,
                              'lastName': lastName,
                            },
                          );
                        },
                      ),
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

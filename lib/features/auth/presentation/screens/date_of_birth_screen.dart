import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/terms_and_service.dart';
import '../bloc/date_of_birth/date_of_birth_bloc.dart';
import '../widgets/auth/auth_background.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/date_of_birth_form.dart';

class DateOfBirthScreen extends StatelessWidget {
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const DateOfBirthScreen({
    super.key,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DateOfBirthBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: AuthBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(currentStep: 4, onBack: () => context.pop()),
                  const SizedBox(height: 48),
                  const Text(
                    'What\'s your\ndate of birth?',
                    style: AppTextStyles.heading,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: DateOfBirthForm(
                      phoneNumber: phoneNumber,
                      firstName: firstName,
                      lastName: lastName,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TermsAndService(),
          ),
        ),
      ),
    );
  }
}

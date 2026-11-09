import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/date_of_birth/date_of_birth_bloc.dart';
import '../bloc/date_of_birth/date_of_birth_event.dart';
import '../bloc/date_of_birth/date_of_birth_state.dart';

class DateOfBirthForm extends StatelessWidget {
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const DateOfBirthForm({
    super.key,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Future<void> _openDatePicker(
    BuildContext context,
    DateOfBirthState state,
  ) async {
    final today = DateTime.now();
    debugPrint('Birth ${state.dateOfBirth}');
    final selectedDate = await showDatePicker(
      context: context,
      initialDate:
          state.dateOfBirth ??
          DateTime(today.year - 13, today.month, today.day),
      firstDate: DateTime(1900),
      lastDate: DateTime(today.year - 13, today.month, today.day),
      helpText: 'SELECT YOUR DATE OF BIRTH',
    );

    if (selectedDate != null && context.mounted) {
      context.read<DateOfBirthBloc>().add(DateOfBirthSelected(selectedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  BlocBuilder<DateOfBirthBloc, DateOfBirthState>(
                    builder: (context, state) {
                      final date = state.dateOfBirth;

                      return Column(
                        children: [
                          _DatePartContainer(
                            value: date == null
                                ? 'Month'
                                : _monthNames[date.month - 1],
                            onTap: () => _openDatePicker(context, state),
                          ),
                          const SizedBox(height: 16),
                          _DatePartContainer(
                            value: date == null ? 'Day' : date.day.toString(),
                            onTap: () => _openDatePicker(context, state),
                          ),
                          const SizedBox(height: 16),
                          _DatePartContainer(
                            value: date == null ? 'Year' : date.year.toString(),
                            onTap: () => _openDatePicker(context, state),
                          ),
                          if (state.errorMessage != null) ...[
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.errorMessage!,
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),

                  const Spacer(),

                  BlocBuilder<DateOfBirthBloc, DateOfBirthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 76,
                        child: ElevatedButton(
                          onPressed: state.isValid
                              ? () {
                                  context.pushNamed(
                                    AppRouteNames.welcome,
                                    queryParameters: {
                                      'phone': phoneNumber,
                                      'firstName': firstName,
                                      'lastName': lastName,
                                      'dateOfBirth': state.dateOfBirth!
                                          .toIso8601String(),
                                    },
                                  );
                                }
                              : null,
                          child: const Text('Continue'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DatePartContainer extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _DatePartContainer({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.disabled),
        ),
        child: Text(value, style: AppTextStyles.body),
      ),
    );
  }
}

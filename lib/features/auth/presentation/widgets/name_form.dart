import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/name/name_bloc.dart';
import '../bloc/name/name_event.dart';
import '../bloc/name/name_state.dart';

class NameForm extends StatefulWidget {
  final String firstName;
  final String lastName;
  final void Function() onContinue;

  const NameForm({
    super.key,
    this.firstName = '',
    this.lastName = '',
    required this.onContinue,
  });

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameBloc, NameState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        context.read<NameBloc>().add(FirstNameChanged(value));
                      },
                      decoration: _inputDecoration(
                        hint: 'First Name',
                        showError:
                            state.firstName.isNotEmpty &&
                            !state.isFirstNameValid,
                      ),
                    ),
                    if (state.firstName.isNotEmpty && !state.isFirstNameValid)
                      _buildError(
                        state.firstName.trim().length > 50
                            ? 'First name must not exceed 50 characters.'
                            : 'Please enter letters only (A-Z or Myanmar).',
                      ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: _lastNameController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        context.read<NameBloc>().add(LastNameChanged(value));
                      },
                      decoration: _inputDecoration(
                        hint: 'Last Name',
                        showError:
                            state.lastName.isNotEmpty && !state.isLastNameValid,
                      ),
                    ),
                    if (state.lastName.isNotEmpty && !state.isLastNameValid)
                      _buildError(
                        state.lastName.trim().length > 50
                            ? 'Last name must not exceed 50 characters.'
                            : 'Please enter letters only (A-Z or Myanmar).',
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 76,
              child: ElevatedButton(
                onPressed: state.isValid ? widget.onContinue : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required bool showError,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      error: null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: showError ? Colors.red : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: showError ? Colors.red : Colors.blue,
          width: 1.5,
        ),
      ),
    );
  }
}

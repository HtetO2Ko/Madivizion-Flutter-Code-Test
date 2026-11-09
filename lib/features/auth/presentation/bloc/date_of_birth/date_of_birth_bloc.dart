import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/validators/date_of_birth_validator.dart';
import 'date_of_birth_event.dart';
import 'date_of_birth_state.dart';

class DateOfBirthBloc extends Bloc<DateOfBirthEvent, DateOfBirthState> {
  DateOfBirthBloc() : super(const DateOfBirthState()) {
    on<DateOfBirthSelected>(_onDateSelected);
  }

  void _onDateSelected(
    DateOfBirthSelected event,
    Emitter<DateOfBirthState> emit,
  ) {
    final error = DateOfBirthValidator.validate(event.date);

    emit(DateOfBirthState(dateOfBirth: event.date, errorMessage: error));
  }
}

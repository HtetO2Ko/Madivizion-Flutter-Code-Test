import 'package:flutter_bloc/flutter_bloc.dart';

import 'name_event.dart';
import 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc({String firstName = '', String lastName = ''})
    : super(NameState(firstName: firstName, lastName: lastName)) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<NameState> emit) {
    emit(state.copyWith(firstName: event.value));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<NameState> emit) {
    emit(state.copyWith(lastName: event.value));
  }
}

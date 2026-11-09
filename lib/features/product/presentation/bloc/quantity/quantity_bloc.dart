import 'package:flutter_bloc/flutter_bloc.dart';

import 'quantity_event.dart';
import 'quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(const QuantityState()) {
    on<QuantityIncremented>((event, emit) {
      emit(QuantityState(quantity: state.quantity + 1));
    });

    on<QuantityDecremented>((event, emit) {
      if (state.quantity > 1) {
        emit(QuantityState(quantity: state.quantity - 1));
      }
    });
  }
}

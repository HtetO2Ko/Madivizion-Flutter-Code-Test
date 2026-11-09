import 'package:flutter_bloc/flutter_bloc.dart';

import 'tabbar_event.dart';
import 'tabbar_state.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  TabbarBloc() : super(const TabbarState()) {
    on<TabChanged>((event, emit) {
      emit(TabbarState(currentIndex: event.index));
    });
  }
}

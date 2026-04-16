import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/bloc/switch/switch_event.dart';
import 'package:bloc_pattern/bloc/switch/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState()) {
    on<EnableOrDisableEvent>((event, emit) {
      emit(state.copyWith(isSwitch: !state.isSwitch));
    });

    on<SliderEvent>((event, emit) {
      emit(state.copyWith(slider: event.slider));
    });
  }
}

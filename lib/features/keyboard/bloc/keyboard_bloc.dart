import 'package:flutter_bloc/flutter_bloc.dart';
import 'keyboard_event.dart';
import 'keyboard_state.dart';

class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  KeyboardBloc() : super(const KeyboardState()) {
    on<KeyPressed>(_onKeyPressed);
    on<BackspacePressed>(_onBackspace);
    on<SpacePressed>(_onSpace);
    on<EnterPressed>(_onEnter);
    on<ShiftToggled>(_onShiftToggled);
    on<LanguageToggled>(_onLanguageToggled);
    on<InputCleared>(_onCleared);
  }

  void _onKeyPressed(KeyPressed event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(
      inputText: state.inputText + event.character,
      isShiftActive: false,
    ));
  }

  void _onBackspace(BackspacePressed event, Emitter<KeyboardState> emit) {
    if (state.inputText.isNotEmpty) {
      emit(state.copyWith(
        inputText: state.inputText.substring(0, state.inputText.length - 1),
      ));
    }
  }

  void _onSpace(SpacePressed event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(inputText: '${state.inputText} '));
  }

  void _onEnter(EnterPressed event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(inputText: '${state.inputText}\n'));
  }

  void _onShiftToggled(ShiftToggled event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(isShiftActive: !state.isShiftActive));
  }

  void _onLanguageToggled(LanguageToggled event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(isArabic: !state.isArabic));
  }

  void _onCleared(InputCleared event, Emitter<KeyboardState> emit) {
    emit(state.copyWith(inputText: ''));
  }
}

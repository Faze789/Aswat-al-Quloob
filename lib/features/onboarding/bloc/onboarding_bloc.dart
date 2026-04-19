import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/platform/keyboard_channel.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const _key = 'onboarding_complete';

  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingStarted>(_onStarted);
    on<OnboardingNextStep>(_onNextStep);
    on<OnboardingPreviousStep>(_onPreviousStep);
    on<OnboardingKeyboardStatusChecked>(_onKeyboardStatusChecked);
    on<OnboardingCompleted>(_onCompleted);
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(_key) ?? false;
    emit(state.copyWith(isComplete: done, isLoading: false));
  }

  void _onNextStep(OnboardingNextStep event, Emitter<OnboardingState> emit) {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPreviousStep(
    OnboardingPreviousStep event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> _onKeyboardStatusChecked(
    OnboardingKeyboardStatusChecked event,
    Emitter<OnboardingState> emit,
  ) async {
    final enabled = await KeyboardChannel.isKeyboardEnabled();
    emit(state.copyWith(isKeyboardEnabled: enabled));
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
    emit(state.copyWith(isComplete: true));
  }
}

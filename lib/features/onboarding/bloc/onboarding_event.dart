import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingStarted extends OnboardingEvent {
  const OnboardingStarted();
}

class OnboardingNextStep extends OnboardingEvent {
  const OnboardingNextStep();
}

class OnboardingPreviousStep extends OnboardingEvent {
  const OnboardingPreviousStep();
}

class OnboardingKeyboardStatusChecked extends OnboardingEvent {
  const OnboardingKeyboardStatusChecked();
}

class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}

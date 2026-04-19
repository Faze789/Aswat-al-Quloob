import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentStep;
  final bool isKeyboardEnabled;
  final bool isComplete;
  final bool isLoading;

  const OnboardingState({
    this.currentStep = 0,
    this.isKeyboardEnabled = false,
    this.isComplete = false,
    this.isLoading = true,
  });

  OnboardingState copyWith({
    int? currentStep,
    bool? isKeyboardEnabled,
    bool? isComplete,
    bool? isLoading,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      isKeyboardEnabled: isKeyboardEnabled ?? this.isKeyboardEnabled,
      isComplete: isComplete ?? this.isComplete,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [currentStep, isKeyboardEnabled, isComplete, isLoading];
}

import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool hapticFeedback;
  final bool soundEnabled;
  final bool isLoading;

  const SettingsState({
    this.hapticFeedback = true,
    this.soundEnabled = false,
    this.isLoading = true,
  });

  SettingsState copyWith({
    bool? hapticFeedback,
    bool? soundEnabled,
    bool? isLoading,
  }) {
    return SettingsState(
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [hapticFeedback, soundEnabled, isLoading];
}

import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoaded extends SettingsEvent {
  const SettingsLoaded();
}

class HapticFeedbackToggled extends SettingsEvent {
  const HapticFeedbackToggled();
}

class SoundToggled extends SettingsEvent {
  const SoundToggled();
}

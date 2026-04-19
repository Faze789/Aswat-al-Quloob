import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const _hapticKey = 'haptic_feedback';
  static const _soundKey = 'sound_enabled';

  SettingsBloc() : super(const SettingsState()) {
    on<SettingsLoaded>(_onLoaded);
    on<HapticFeedbackToggled>(_onHapticToggled);
    on<SoundToggled>(_onSoundToggled);
  }

  Future<void> _onLoaded(
    SettingsLoaded event,
    Emitter<SettingsState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(
      hapticFeedback: prefs.getBool(_hapticKey) ?? true,
      soundEnabled: prefs.getBool(_soundKey) ?? false,
      isLoading: false,
    ));
  }

  Future<void> _onHapticToggled(
    HapticFeedbackToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final value = !state.hapticFeedback;
    emit(state.copyWith(hapticFeedback: value));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hapticKey, value);
  }

  Future<void> _onSoundToggled(
    SoundToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final value = !state.soundEnabled;
    emit(state.copyWith(soundEnabled: value));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, value);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';
import 'package:aswat_al_quloob/core/constants/app_strings.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_bloc.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_event.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_state.dart';
import 'package:aswat_al_quloob/features/keyboard/presentation/keyboard_view.dart';
import 'package:aswat_al_quloob/features/settings/bloc/settings_bloc.dart';
import 'package:aswat_al_quloob/features/settings/bloc/settings_event.dart';
import 'package:aswat_al_quloob/features/settings/bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Keyboard preview
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.tryKeyboard,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<KeyboardBloc, KeyboardState>(
                          buildWhen: (prev, curr) =>
                              prev.inputText != curr.inputText,
                          builder: (context, state) {
                            return Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 80),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                state.inputText.isEmpty
                                    ? AppStrings.typeHere
                                    : state.inputText,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: state.inputText.isEmpty
                                      ? AppColors.textSecondary
                                      : AppColors.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => context
                                .read<KeyboardBloc>()
                                .add(const InputCleared()),
                            icon: const Icon(Icons.clear, size: 18),
                            label: const Text('Clear'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Settings toggles
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    AppStrings.keyboardSettings,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Card(
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: const Text(AppStrings.hapticFeedback),
                            subtitle:
                                const Text(AppStrings.hapticFeedbackDesc),
                            value: state.hapticFeedback,
                            activeTrackColor: AppColors.primary,
                            onChanged: (_) => context
                                .read<SettingsBloc>()
                                .add(const HapticFeedbackToggled()),
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          SwitchListTile(
                            title: const Text(AppStrings.soundOnPress),
                            subtitle:
                                const Text(AppStrings.soundOnPressDesc),
                            value: state.soundEnabled,
                            activeTrackColor: AppColors.primary,
                            onChanged: (_) => context
                                .read<SettingsBloc>()
                                .add(const SoundToggled()),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // About
                Card(
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'أ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: const Text(AppStrings.appName),
                    subtitle: const Text(AppStrings.version),
                    trailing: const Text(
                      AppStrings.appNameArabic,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Embedded keyboard
          const KeyboardView(),
        ],
      ),
    );
  }
}

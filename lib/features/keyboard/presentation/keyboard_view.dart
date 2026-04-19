import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';
import 'package:aswat_al_quloob/core/constants/app_strings.dart';
import 'package:aswat_al_quloob/core/constants/arabic_layout.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_bloc.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_event.dart';
import 'package:aswat_al_quloob/features/keyboard/bloc/keyboard_state.dart';
import 'widgets/key_button.dart';
import 'widgets/keyboard_row.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyboardBloc, KeyboardState>(
      builder: (context, state) {
        final layout = state.isShiftActive
            ? ArabicLayout.shiftLayout
            : ArabicLayout.mainLayout;
        final bloc = context.read<KeyboardBloc>();

        return Container(
          color: AppColors.keyboardBackground,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row 1
              KeyboardRow(
                keys: layout[0]
                    .map((c) => KeyButton(
                          label: c,
                          onTap: () => bloc.add(KeyPressed(c)),
                        ))
                    .toList(),
              ),
              // Row 2
              KeyboardRow(
                keys: layout[1]
                    .map((c) => KeyButton(
                          label: c,
                          onTap: () => bloc.add(KeyPressed(c)),
                        ))
                    .toList(),
              ),
              // Row 3 — shift + letters + backspace
              KeyboardRow(
                keys: [
                  KeyButton(
                    label: '',
                    icon: Icons.arrow_upward,
                    backgroundColor: state.isShiftActive
                        ? AppColors.primary
                        : AppColors.specialKey,
                    textColor:
                        state.isShiftActive ? Colors.white : AppColors.keyText,
                    onTap: () => bloc.add(const ShiftToggled()),
                    flex: 1.3,
                  ),
                  ...layout[2].map((c) => KeyButton(
                        label: c,
                        onTap: () => bloc.add(KeyPressed(c)),
                      )),
                  KeyButton(
                    label: '',
                    icon: Icons.backspace_outlined,
                    backgroundColor: AppColors.specialKey,
                    onTap: () => bloc.add(const BackspacePressed()),
                    flex: 1.3,
                  ),
                ],
              ),
              // Row 4 — bottom controls + spacebar
              KeyboardRow(
                keys: [
                  KeyButton(
                    label: '',
                    icon: Icons.language,
                    backgroundColor: AppColors.specialKey,
                    onTap: () => bloc.add(const LanguageToggled()),
                    flex: 1.2,
                  ),
                  KeyButton(
                    label: '،',
                    backgroundColor: AppColors.specialKey,
                    onTap: () => bloc.add(const KeyPressed('،')),
                  ),
                  KeyButton(
                    label: AppStrings.appNameArabic,
                    onTap: () => bloc.add(const SpacePressed()),
                    flex: 4.0,
                  ),
                  KeyButton(
                    label: '.',
                    backgroundColor: AppColors.specialKey,
                    onTap: () => bloc.add(const KeyPressed('.')),
                  ),
                  KeyButton(
                    label: '',
                    icon: Icons.keyboard_return,
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    onTap: () => bloc.add(const EnterPressed()),
                    flex: 1.2,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

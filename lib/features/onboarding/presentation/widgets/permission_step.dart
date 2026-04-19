import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';
import 'package:aswat_al_quloob/core/constants/app_strings.dart';
import 'package:aswat_al_quloob/core/platform/keyboard_channel.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_event.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_state.dart';
import 'package:aswat_al_quloob/shared/widgets/gradient_button.dart';

class PermissionStep extends StatelessWidget {
  const PermissionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.keyboard_alt_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            AppStrings.permissionTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.permissionSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          _StepCard(number: '1', text: AppStrings.permissionStep1, icon: Icons.settings),
          const SizedBox(height: 12),
          _StepCard(number: '2', text: AppStrings.permissionStep2, icon: Icons.toggle_on_outlined),
          const SizedBox(height: 24),
          GradientButton(
            text: AppStrings.openSettings,
            onPressed: () => KeyboardChannel.openKeyboardSettings(),
          ),
          const SizedBox(height: 12),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            buildWhen: (prev, curr) =>
                prev.isKeyboardEnabled != curr.isKeyboardEnabled,
            builder: (context, state) {
              if (state.isKeyboardEnabled) {
                return Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Keyboard enabled!',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GradientButton(
                      text: AppStrings.next,
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(const OnboardingNextStep());
                      },
                    ),
                  ],
                );
              }
              return TextButton(
                onPressed: () {
                  context
                      .read<OnboardingBloc>()
                      .add(const OnboardingKeyboardStatusChecked());
                },
                child: const Text(AppStrings.checkStatus),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.permissionNote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final String text;
  final IconData icon;

  const _StepCard({
    required this.number,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Icon(icon, color: AppColors.textSecondary, size: 24),
        ],
      ),
    );
  }
}

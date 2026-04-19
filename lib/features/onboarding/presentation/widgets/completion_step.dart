import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';
import 'package:aswat_al_quloob/core/constants/app_strings.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_event.dart';
import 'package:aswat_al_quloob/shared/widgets/gradient_button.dart';

class CompletionStep extends StatelessWidget {
  const CompletionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0x1A4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 56,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            AppStrings.completionTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.completionSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          const Text(
            AppStrings.completionBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 48),
          GradientButton(
            text: AppStrings.getStarted,
            onPressed: () {
              context.read<OnboardingBloc>().add(const OnboardingCompleted());
            },
          ),
        ],
      ),
    );
  }
}

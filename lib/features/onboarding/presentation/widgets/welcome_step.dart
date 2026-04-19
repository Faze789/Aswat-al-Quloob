import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';
import 'package:aswat_al_quloob/core/constants/app_strings.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:aswat_al_quloob/features/onboarding/bloc/onboarding_event.dart';
import 'package:aswat_al_quloob/shared/widgets/gradient_button.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.primaryShadow,
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'أ',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            AppStrings.welcomeTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            AppStrings.appNameArabic,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.welcomeSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          GradientButton(
            text: AppStrings.next,
            onPressed: () {
              context.read<OnboardingBloc>().add(const OnboardingNextStep());
            },
          ),
        ],
      ),
    );
  }
}

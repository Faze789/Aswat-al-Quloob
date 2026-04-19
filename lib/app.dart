import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';
import 'features/onboarding/bloc/onboarding_event.dart';
import 'features/onboarding/bloc/onboarding_state.dart';
import 'features/onboarding/presentation/onboarding_page.dart';
import 'features/settings/bloc/settings_bloc.dart';
import 'features/settings/bloc/settings_event.dart';
import 'features/settings/presentation/settings_page.dart';
import 'features/keyboard/bloc/keyboard_bloc.dart';

class AswatAlQuloobApp extends StatelessWidget {
  const AswatAlQuloobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnboardingBloc()..add(const OnboardingStarted()),
        ),
        BlocProvider(
          create: (_) => SettingsBloc()..add(const SettingsLoaded()),
        ),
        BlocProvider(create: (_) => KeyboardBloc()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const _RootPage(),
      ),
    );
  }
}

class _RootPage extends StatelessWidget {
  const _RootPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.isComplete != curr.isComplete,
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return state.isComplete ? const SettingsPage() : const OnboardingPage();
      },
    );
  }
}

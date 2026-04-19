import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary palette — deep teal inspired by Islamic geometric art
  static const Color primary = Color(0xFF0D7377);
  static const Color primaryLight = Color(0xFF14A3A8);
  static const Color primaryDark = Color(0xFF094F52);

  // Accent — warm gold
  static const Color accent = Color(0xFFD4A843);
  static const Color accentLight = Color(0xFFE8C76A);

  // Surfaces
  static const Color surface = Color(0xFFFAF9F6);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color card = Color(0xFFFFFFFF);

  // Keyboard
  static const Color keyBackground = Color(0xFFE8E8ED);
  static const Color keyText = Color(0xFF1C1C1E);
  static const Color keyPressed = Color(0xFFBDBDC7);
  static const Color keyboardBackground = Color(0xFFD1D1D6);
  static const Color specialKey = Color(0xFFADB0B8);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Pre-computed shadow colors (avoid withOpacity at render time)
  static const Color primaryShadow = Color(0x4D0D7377);
  static const Color primaryTint = Color(0x1A0D7377);
  static const Color subtleShadow = Color(0x12000000);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aswat_al_quloob/core/constants/app_colors.dart';

class KeyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double flex;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const KeyButton({
    super.key,
    required this.label,
    required this.onTap,
    this.flex = 1.0,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (flex * 10).round(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        child: Material(
          color: backgroundColor ?? AppColors.keyBackground,
          borderRadius: BorderRadius.circular(8),
          elevation: 1,
          shadowColor: AppColors.subtleShadow,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              HapticFeedback.lightImpact();
              onTap();
            },
            child: Container(
              height: 46,
              alignment: Alignment.center,
              child: icon != null
                  ? Icon(icon, size: 22, color: textColor ?? AppColors.keyText)
                  : Text(
                      label,
                      style: TextStyle(
                        fontSize: label.length > 1 ? 14 : 22,
                        color: textColor ?? AppColors.keyText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

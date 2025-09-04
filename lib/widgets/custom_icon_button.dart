import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon; // optional
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon, // nullable
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.textPrimary,
    this.iconColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
    )
        : ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, color: iconColor),
      label: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}

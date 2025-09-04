import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLength;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLength = 50,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        counterText: "", // hides character counter
      ),
    );
  }
}

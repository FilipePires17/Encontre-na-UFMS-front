import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.charcoalGrey,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.white,
        ),
        fillColor: AppColors.charcoalGrey,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.p16,
          vertical: Sizes.p4,
        ),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(
        color: AppColors.white,
      ),
      controller: controller,
      validator: validator,
    );
  }
}

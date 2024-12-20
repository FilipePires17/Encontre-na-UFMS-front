import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.isRequired = false,
    this.onTap,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    this.maxLines,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool isRequired;
  final Function()? onTap;
  final bool isReadOnly;
  final bool isEnabled;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      scrollPhysics: const BouncingScrollPhysics(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.charcoalGrey,
        ),
        labelText: isRequired ? '$labelText *' : labelText,
        alignLabelWithHint: true,
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
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      readOnly: isReadOnly,
      enabled: isEnabled,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      initialValue: initialValue,
      maxLines: maxLines ?? 1,
    );
  }
}

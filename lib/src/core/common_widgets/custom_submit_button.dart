import 'package:flutter/material.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';
import '../utils/string_extension.dart';

class CustomSubmitButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? width;
  final Widget? icon;
  final double height;
  final bool isFilled;
  final double radius;
  final bool isLoading;
  final Color? customColor;

  const CustomSubmitButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
    this.icon,
    this.height = Sizes.p40,
    this.isFilled = true,
    this.isLoading = false,
    this.radius = Sizes.p8,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
      child: SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: ElevatedButton(
          style: isFilled
              ? ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  backgroundColor: customColor ?? AppColors.primary,
                )
              : ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  backgroundColor: AppColors.transparent,
                ),
          onPressed: isLoading ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              Text(
                title.capitalize(),
                style: const TextStyle(
                  fontSize: Sizes.p16,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

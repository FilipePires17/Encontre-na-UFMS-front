import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../domain/enums/enum_location.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.location,
    this.onPressed,
    this.isPressed = false,
  });

  final EnumLocation location;
  final Function()? onPressed;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Sizes.p16),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.p8,
        ),
        height: Sizes.p36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.p16),
          color: isPressed ? AppColors.secondary : AppColors.primary,
        ),
        child: Center(
          child: Text(
            location.title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

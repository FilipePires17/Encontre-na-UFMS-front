import 'package:flutter/material.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    String? title,
    required BuildContext context,
    super.actions,
    double? fontSize,
  }) : super(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize ?? Sizes.p32,
                    color: AppColors.white,
                  ),
                )
              : null,
          centerTitle: true,
        );
}

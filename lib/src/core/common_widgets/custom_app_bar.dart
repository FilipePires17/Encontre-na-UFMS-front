import 'package:flutter/material.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required String title,
    required BuildContext context,
    super.actions,
  }) : super(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: Sizes.p32,
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
        );
}

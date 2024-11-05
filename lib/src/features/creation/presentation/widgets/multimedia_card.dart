import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class MultimediaCard extends StatelessWidget {
  const MultimediaCard({
    super.key,
    required this.multimedia,
    this.onTap,
    this.isRemovable = true,
  });

  final Uint8List multimedia;
  final bool isRemovable;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Sizes.p56,
          padding: const EdgeInsets.only(
            top: Sizes.p4,
            right: Sizes.p4,
          ),
          color: AppColors.transparent,
          child: Image.memory(
            multimedia,
            fit: BoxFit.fitHeight,
          ),
        ),
        if (isRemovable)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: Sizes.p10,
                  height: Sizes.p10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                    color: AppColors.transparent,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: Sizes.p8,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

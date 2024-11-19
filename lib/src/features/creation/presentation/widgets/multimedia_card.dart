import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class MultimediaCard extends StatelessWidget {
  const MultimediaCard({
    super.key,
    this.multimedia,
    this.url,
    this.onTap,
    this.isRemovable = true,
  });

  final Uint8List? multimedia;
  final String? url;
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
          child: multimedia != null
              ? Image.memory(
                  multimedia!,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image_not_supported),
                    );
                  },
                )
              : url != null
                  ? CachedNetworkImage(
                      imageUrl: url!,
                      fit: BoxFit.fitHeight,
                      errorWidget: (context, url, error) {
                        return const Center(
                          child: Icon(Icons.image_not_supported),
                        );
                      })
                  : const Center(
                      child: Icon(Icons.image),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../domain/entities/location_list_item.dart';

class LocationListItemTile extends StatelessWidget {
  const LocationListItemTile({
    super.key,
    required this.location,
    this.onPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
  });

  final LocationListItem location;
  final Function()? onPressed;
  final Function()? onFavoritePressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Center(
                  child: location.multimedia.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: location.multimedia.first.mediaUrl ?? '',
                          fit: BoxFit.fitHeight,
                          errorWidget: (_, __, ___) {
                            return const Icon(Icons.image_not_supported);
                          },
                        )
                      : const Icon(Icons.image),
                ),
                if (location.viewed)
                  const Positioned(
                    bottom: 4,
                    right: 4,
                    child: Icon(
                      Icons.visibility,
                      color: AppColors.translucentCharcoalGrey,
                    ),
                  ),
              ],
            ),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  location.name,
                  style: const TextStyle(
                    fontSize: Sizes.p20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.p8,
                    vertical: Sizes.p4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Sizes.p16),
                    ),
                    border: Border.all(
                      color: AppColors.secondary,
                    ),
                  ),
                  child: Text(
                    location.type.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: Sizes.p10,
                    ),
                  ),
                ),
                Text(
                  location.address,
                  style: const TextStyle(
                    color: AppColors.lightGray,
                  ),
                ),
                if (location.isOpen != true)
                  const Text(
                    'Provavelmente Fechado',
                    style: TextStyle(color: AppColors.secondary),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoritePressed,
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? AppColors.secondary : AppColors.charcoalGrey,
              size: Sizes.p36,
            ),
          ),
        ],
      ),
    );
  }
}

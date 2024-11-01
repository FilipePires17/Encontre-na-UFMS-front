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
      child: SizedBox(
        height: Sizes.p100,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Center(
                    child: location.multimedia.isNotEmpty
                        ? Image.memory(
                            location.multimedia.first.media,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (context, error, stackTrace) {
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
                  Text(location.address),
                  if (location.isOpen == true)
                    const Text(
                      'Aberto agora',
                      style: TextStyle(color: AppColors.primary),
                    )
                  else
                    const Text(
                      'Fechado',
                      style: TextStyle(color: AppColors.secondary),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: AppColors.secondary,
                size: Sizes.p36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

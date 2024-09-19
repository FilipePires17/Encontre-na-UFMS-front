import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../location/domain/entities/location.dart';

class LocationListItemTile extends StatelessWidget {
  const LocationListItemTile({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/location');
      },
      child: SizedBox(
        height: Sizes.p100,
        child: Row(
          children: <Widget>[
            Container(
              color: AppColors.primary,
              width: 100,
              height: 100,
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    location.name,
                    style: const TextStyle(
                      fontSize: Sizes.p16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(location.address),
                  if (location.isOpen == true)
                    const Text('Aberto agora')
                  else
                    const Text('Fechado'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star_border,
                size: Sizes.p36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

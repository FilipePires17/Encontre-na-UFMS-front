import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class LocationListItemTile extends StatelessWidget {
  const LocationListItemTile({super.key});

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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Location Name',
                    style: TextStyle(
                      fontSize: Sizes.p16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Location Address'),
                  Text('Aberto agora'),
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

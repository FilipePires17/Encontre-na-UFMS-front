import 'package:flutter/material.dart';

import '../../../../core/constants/theme/app_colors.dart';

class StarIcon extends StatelessWidget {
  final double fill;
  final double size;

  const StarIcon({super.key, required this.fill, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.star_border,
          size: size,
          color: AppColors.backgroundGrey,
        ),
        ClipRect(
          clipper: _StarClipper(fill: fill),
          child: Icon(
            Icons.star,
            size: size,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fill;

  _StarClipper({required this.fill});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fill, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return oldClipper.fill != fill;
  }
}

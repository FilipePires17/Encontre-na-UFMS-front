import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import 'star_icon.dart';

class ReviewSection extends StatefulWidget {
  const ReviewSection({
    super.key,
    required this.name,
    required this.rating,
    this.onReviewChanged,
  });

  final String name;
  final double rating;
  final Function(double newRating)? onReviewChanged;

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  double userRating = 0;

  void updateRating(Offset localPosition) {
    userRating = (localPosition.dx / 30).clamp(0.0, 5.0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            updateRating(details.localPosition);
          },
          onPanEnd: (details) {
            double newRating = (details.localPosition.dx / 30).clamp(0.0, 5.0);
            widget.onReviewChanged?.call(newRating);
          },
          onTapDown: (details) {
            updateRating(details.localPosition);
            double newRating = (details.localPosition.dx / 30).clamp(0.0, 5.0);
            widget.onReviewChanged?.call(newRating);
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (index) {
                double fill = 0.0;
                debugPrint(userRating.toString());
                if (userRating >= index + 1) {
                  fill = 1.0;
                } else if (userRating > index) {
                  fill = userRating - index;
                }
                return StarIcon(fill: fill, size: Sizes.p32);
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onReviewChanged?.call(0);
            userRating = 0;
            setState(() {});
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.fadedDarkGreen,
            size: Sizes.p28,
          ),
        ),
      ],
    );
  }
}

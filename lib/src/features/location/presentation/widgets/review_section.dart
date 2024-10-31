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
  @override
  Widget build(BuildContext context) {
    double userRating = 0;

    void updateRating(Offset localPosition) {
      double newRating = (localPosition.dx / 30).clamp(0.0, 5.0);
      userRating = newRating;
      widget.onReviewChanged?.call(newRating);
      setState(() {});
    }

    return Container(
      color: AppColors.charcoalGrey,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Text((widget.rating).toString()),
                  const Icon(
                    Icons.star,
                    color: AppColors.yellow,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onPanEnd: (details) {
              updateRating(details.localPosition);
              debugPrint(details.localPosition.dx.toString());
            },
            onTapDown: (details) {
              updateRating(details.localPosition);
              debugPrint(details.localPosition.dx.toString());
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) {
                  double fill = 0.0;
                  if (userRating >= index + 1) {
                    fill = 1.0;
                  } else if (userRating > index) {
                    fill = userRating - index;
                  }
                  return StarIcon(fill: fill, size: 30);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

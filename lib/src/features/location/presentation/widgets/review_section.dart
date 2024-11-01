import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../cubit/review_cubit.dart';
import 'star_icon.dart';

class ReviewSection extends StatefulWidget {
  const ReviewSection({
    super.key,
    required this.locationId,
  });

  final int locationId;

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  late double userRating;
  late ReviewCubit reviewCubit;
  static const starSize = Sizes.p24;

  void updateRating(Offset localPosition) {
    userRating = (localPosition.dx / starSize).clamp(0.0, 5.0);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    reviewCubit = BlocProvider.of<ReviewCubit>(context);
    reviewCubit.getReview(widget.locationId);
    setState(() {
      userRating = reviewCubit.state.rating;
    });
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
            double newRating =
                (details.localPosition.dx / starSize).clamp(0.0, 5.0);
            reviewCubit.updateReview(widget.locationId, newRating);
          },
          onTapUp: (details) {
            updateRating(details.localPosition);
            double newRating =
                (details.localPosition.dx / starSize).clamp(0.0, 5.0);
            reviewCubit.updateReview(widget.locationId, newRating);
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
                return StarIcon(fill: fill, size: starSize);
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            userRating = 0;
            reviewCubit.deleteReview(widget.locationId);
            setState(() {});
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.fadedDarkGreen,
            size: starSize - 2,
          ),
        ),
      ],
    );
  }
}

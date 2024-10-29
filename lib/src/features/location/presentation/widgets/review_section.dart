import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import 'star_icon.dart';

class ReviewSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double _rating = 0;
    void _updateRating(Offset localPosition) {
      // Calcula a avaliação baseada na posição do toque
      double newRating = (localPosition.dx / 20).clamp(0.0, 5.0);
      _rating = newRating;
      onReviewChanged?.call(newRating);
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
                name,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Text((rating).toString()),
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
            onPanUpdate: (details) {
              // Atualiza o rating enquanto o usuário arrasta
              _updateRating(details.localPosition);
            },
            onTapDown: (details) {
              // Atualiza o rating ao tocar em uma posição específica
              _updateRating(details.localPosition);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                // Determina o preenchimento da estrela
                double fill = 0.0;
                if (_rating >= index + 1) {
                  fill = 1.0;
                } else if (_rating > index) {
                  fill = _rating - index;
                }
                return StarIcon(fill: fill, size: 30);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

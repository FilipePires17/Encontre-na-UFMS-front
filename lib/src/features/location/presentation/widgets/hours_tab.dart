import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../domain/entities/sections.dart';

class HoursTab extends StatelessWidget {
  const HoursTab({super.key, required this.hoursSection});

  final HoursSection hoursSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH12,
            Text(
              'Segunda: ${hoursSection.mondayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            Text(
              'Terça: ${hoursSection.tuesdayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            Text(
              'Quarta: ${hoursSection.wednesdayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            Text(
              'Quinta: ${hoursSection.thursdayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            Text(
              'Sexta: ${hoursSection.fridayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            gapH12,
            Text(
              'Sábado: ${hoursSection.saturdayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
            Text(
              'Domingos e feriados: ${hoursSection.sundayHours}',
              style: const TextStyle(fontSize: Sizes.p16),
            ),
          ],
        ),
      ),
    );
  }
}

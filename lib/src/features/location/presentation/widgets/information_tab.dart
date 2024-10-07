import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/utils/string_extension.dart';
import '../../domain/entities/sections.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({
    super.key,
    required this.moreInfoSection,
  });

  final MoreInfoSection moreInfoSection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH8,
            if (moreInfoSection.about != null) ...[
              const Text(
                'Sobre',
                style: TextStyle(
                  fontSize: Sizes.p16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH8,
              Text(
                moreInfoSection.about!,
                style: const TextStyle(
                  fontSize: Sizes.p14,
                ),
              ),
            ],
            if (moreInfoSection.observations != null) ...[
              gapH8,
              const Text(
                'Observações',
                style: TextStyle(
                  fontSize: Sizes.p16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH8,
              Text(
                moreInfoSection.observations!,
                style: const TextStyle(
                  fontSize: Sizes.p14,
                ),
              ),
            ],
            gapH8,
            const Text(
              'Telefone',
              style: TextStyle(
                fontSize: Sizes.p16,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapH8,
            Text(
              moreInfoSection.phone.phoneFormat(),
              style: const TextStyle(
                fontSize: Sizes.p14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

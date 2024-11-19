import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/string_extension.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../../domain/entities/sections.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({
    super.key,
    required this.moreInfoSection,
  });

  final MoreInfoSection moreInfoSection;

  @override
  Widget build(BuildContext context) {
    return moreInfoSection.hasInfo
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH8,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.p8,
                      vertical: Sizes.p4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Sizes.p16),
                      ),
                      border: Border.all(
                        color: AppColors.secondary,
                      ),
                    ),
                    child: Text(
                      moreInfoSection.locationType!.title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: Sizes.p10,
                      ),
                    ),
                  ),
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
                    moreInfoSection.phone?.phoneFormat() ?? '',
                    style: const TextStyle(
                      fontSize: Sizes.p14,
                    ),
                  ),
                  gapH8,
                  if (moreInfoSection.about != null &&
                      moreInfoSection.about!.isNotEmpty) ...[
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
                  if (moreInfoSection.observations != null &&
                      moreInfoSection.observations!.isNotEmpty) ...[
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
                  if (moreInfoSection.specialInfo != null)
                    switch (moreInfoSection.locationType) {
                      EnumLocation.academicBlocks =>
                        (moreInfoSection.specialInfo!.course ?? '').isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  gapH8,
                                  const Text(
                                    'Cursos Oferecidos',
                                    style: TextStyle(
                                      fontSize: Sizes.p16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapH8,
                                  Text(
                                    moreInfoSection.specialInfo!.course!,
                                    style: const TextStyle(
                                      fontSize: Sizes.p14,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      EnumLocation.libraries =>
                        (moreInfoSection.specialInfo!.libraryLink ?? '')
                                .isNotEmpty
                            ? Column(
                                children: [
                                  gapH8,
                                  const Text(
                                    'Link da Biblioteca',
                                    style: TextStyle(
                                      fontSize: Sizes.p16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapH8,
                                  Text(
                                    moreInfoSection.specialInfo!.libraryLink!,
                                    style: const TextStyle(
                                      fontSize: Sizes.p14,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      EnumLocation.sportsCenters =>
                        (moreInfoSection.specialInfo!.availableSports ?? '')
                                .isNotEmpty
                            ? Column(
                                children: [
                                  gapH8,
                                  const Text(
                                    'Modalidades Oferecidas',
                                    style: TextStyle(
                                      fontSize: Sizes.p16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapH8,
                                  Text(
                                    moreInfoSection
                                        .specialInfo!.availableSports!,
                                    style: const TextStyle(
                                      fontSize: Sizes.p14,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      EnumLocation.transports =>
                        (moreInfoSection.specialInfo!.availableBuses ?? '')
                                .isNotEmpty
                            ? Column(
                                children: [
                                  gapH8,
                                  const Text(
                                    'Linhas de Ônibus',
                                    style: TextStyle(
                                      fontSize: Sizes.p16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  gapH8,
                                  Text(
                                    moreInfoSection
                                        .specialInfo!.availableBuses!,
                                    style: const TextStyle(
                                      fontSize: Sizes.p14,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      _ => const SizedBox.shrink(),
                    },
                ],
              ),
            ),
          )
        : const Center(
            child: Text(
              'Nenhuma informação disponível',
              style: TextStyle(
                fontSize: Sizes.p16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

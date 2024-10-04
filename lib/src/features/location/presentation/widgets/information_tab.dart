import 'package:flutter/material.dart';

import '../../domain/entities/sections.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({
    super.key,
    required this.moreInfoSection,
  });

  final MoreInfoSection moreInfoSection;

  @override
  Widget build(BuildContext context) {
    return const Text('Informações');
  }
}

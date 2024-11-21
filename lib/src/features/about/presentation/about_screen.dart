import 'package:flutter/material.dart';

import '../../../core/common_widgets/custom_app_bar.dart';
import '../../../core/constants/sizes/app_sizes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SOBRE',
        context: context,
      ),
      body: const Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p8),
        child: Text(
          'Desenvolvido por Filipe dos Santos Pires e Wilson Eduardo Fantucci'
          ' Diniz de Almeida como trabalho de conclusão do curso de Engenharia'
          ' de Computação da Universidade Federal de Mato Grosso do Sul.',
          style: TextStyle(fontSize: Sizes.p16),
        ),
      ),
    );
  }
}

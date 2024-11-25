import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/common_widgets/custom_app_bar.dart';
import '../../../core/constants/sizes/app_sizes.dart';
import '../../../core/constants/theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SOBRE',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16, vertical: Sizes.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Desenvolvido por Filipe dos Santos Pires e Wilson Eduardo Fantucci'
              ' Diniz de Almeida como trabalho de conclusão do curso de Engenharia'
              ' de Computação da Universidade Federal de Mato Grosso do Sul.',
              style: TextStyle(fontSize: Sizes.p16),
            ),
            gapH12,
            const Text(
              'Orientadora: Prof. Dra. Ana Karina Dourado Salina de Oliveira',
              style: TextStyle(fontSize: Sizes.p16),
            ),
            gapH32,
            const Text(
              'Links úteis:',
              style: TextStyle(fontSize: Sizes.p16),
            ),
            gapH12,
            TextButton(
              child: const Text(
                'Repositório do Front-end',
              ),
              onPressed: () async {
                final Uri uri = Uri.parse(
                    'https://github.com/FilipePires17/Encontre-na-UFMS-front');
                if (!await launchUrl(uri)) {
                  throw 'Could not launch ${uri.toString()}';
                }
              },
            ),
            TextButton(
              child: const Text(
                'Repositório do Back-end',
              ),
              onPressed: () async {
                final Uri uri =
                    Uri.parse('https://github.com/wildevn/EncontreNaUfmsAPI');
                if (!await launchUrl(uri)) {
                  throw 'Could not launch ${uri.toString()}';
                }
              },
            ),
            TextButton(
              child: const Text(
                'Artigo',
              ),
              onPressed: () async {
                final Uri uri =
                    Uri.parse('https://github.com/FilipePires17/tcc');
                if (!await launchUrl(uri)) {
                  throw 'Could not launch ${uri.toString()}';
                }
              },
            ),
            const Spacer(),
            const Text(
              'Versão 1.0',
              style: TextStyle(
                fontSize: Sizes.p16,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

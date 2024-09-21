import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + Sizes.p16,
              left: Sizes.p32,
            ),
            child: const Text(
              'Encontre na UFMS',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.white,
                fontSize: Sizes.p24,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: CustomSubmitButton(
              title: 'Perfil',
              onPressed: () {},
            ),
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: CustomSubmitButton(
              title: 'Sobre',
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.about);
              },
            ),
          ),
          gapH32,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: CustomSubmitButton(
              title: 'Sair',
              onPressed: () {},
              customColor: AppColors.secondary,
            ),
          ),
          gapH12,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Encontre na UFMS',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Perfil',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Sobre',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}

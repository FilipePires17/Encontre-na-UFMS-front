import 'package:flutter/material.dart';

import '../../../core/common_widgets/custom_app_bar.dart';
import '../../../core/constants/sizes/app_sizes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'SOBRE',
        context: context,
      ),
      body: const Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p8),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
          'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
          'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
          'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
          'culpa qui officia deserunt mollit anim id est laborum.',
          style: TextStyle(fontSize: Sizes.p16),
        ),
      ),
    );
  }
}

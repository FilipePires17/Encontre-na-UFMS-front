import 'package:flutter/material.dart';

import '../constants/sizes/app_sizes.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required String text,
    required BuildContext context,
    super.actions,
  }) : super(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            text,
            style: const TextStyle(fontSize: Sizes.p32),
          ),
          centerTitle: true,
        );
}

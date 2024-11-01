import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/theme/app_colors.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _applyStatusBarStyle();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _applyStatusBarStyle();
  }

  void _applyStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.black, // Defina a cor desejada aqui
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}

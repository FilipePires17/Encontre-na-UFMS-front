import 'package:flutter/material.dart';

import 'src/core/data/local/hive_initializer.dart';
import 'src/config/services/injection_container.dart' as getit;
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitialize().init();
  getit.init();
  runApp(const MyApp());
}

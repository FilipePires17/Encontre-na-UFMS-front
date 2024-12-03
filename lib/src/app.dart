import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/routing/app_router.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encontre na UFMS',
      theme: ThemeData(),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      themeMode: ThemeMode.dark,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.getRoute,
    );
  }
}

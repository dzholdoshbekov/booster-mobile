import 'package:booster/core/router/app_routes.dart';
import 'package:booster/core/constants/theme/theme.dart';
import 'package:flutter/material.dart';

class BoosterApp extends StatelessWidget {
  const BoosterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      routes: appRoutes,
    );
  }
}

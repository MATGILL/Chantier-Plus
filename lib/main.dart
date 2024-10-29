import 'package:chantier_plus/core/configs/theme/app_theme.dart';
import 'package:chantier_plus/presentation/page/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

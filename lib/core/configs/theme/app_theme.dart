import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      brightness: Brightness.light,
      indicatorColor: AppColors.primary,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        indicatorColor: AppColors.primary,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          focusColor: AppColors.primary, backgroundColor: AppColors.primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Couleur de fond
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Ajuste le rayon ici
          ),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 24.0, // Ajuste la taille de texte ici
            fontWeight: FontWeight.bold, // Ajuste le poids de texte ici
            color: Colors.white, // Couleur du texte
          ),
          fixedSize: const Size(214, 52),
        ),
      ),
      appBarTheme: const AppBarTheme(color: AppColors.lightBackground));
} 

//TODO maybe install a darkTheme later


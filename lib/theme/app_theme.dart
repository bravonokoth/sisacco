import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color deepBlueViolet = Color(0xFF2D1B69);
  static const Color purple = Color(0xFF7B2CBF);
  static const Color lightPurple = Color(0xFF9D4EDD);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF8F9FA);
  static const Color darkGray = Color(0xFF495057);
  static const Color black = Color(0xFF212529);
  
  // Accent Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [deepBlueViolet, purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF3D2C8D), Color(0xFF8E44AD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: AppColors.deepBlueViolet,
      scaffoldBackgroundColor: AppColors.lightGray,
      // fontFamily: 'Inter',
      
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.deepBlueViolet,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.white,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.purple, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.purple,
        unselectedItemColor: AppColors.darkGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: AppColors.deepBlueViolet,
      scaffoldBackgroundColor: const Color(0xFF121212),
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.deepBlueViolet,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF1E1E1E),
      ),
    );
  }
}

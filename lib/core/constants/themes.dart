import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
   static const Color background = Color(0xFF0D0D0D);          // خلفية داكنة
  static const Color inputDark = Color(0xFF1D1D1D);            // الحقول والنصوص
  static const Color greenAccent = Color(0xFF00FF84);          // أخضر نيون للتأكيد
  static const Color white = Colors.white;                     // أبيض للنصوص الأساسية
  static const Color white70 = Colors.white70;                 // رمادي فاتح للنصوص الثانوية
  static const Color border = Color(0xFF2A2A2A);               // حدود خفيفة
  static const Color error = Colors.redAccent;                 // لون الخطأ
  static const Color googleColor = Color(0xFFDB4437);          // لون زر Google
  static const Color appleColor = Color(0xFF000000);           // لون زر Apple
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.greenAccent,

  // ✅ النصوص الافتراضية
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: AppColors.white,
    displayColor: AppColors.white,
  ),

  // ✅ شريط التطبيق العلوي
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // ✅ زر "ElevatedButton"
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.greenAccent,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),

  // ✅ زر "OutlinedButton"
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.white,
      side: const BorderSide(color: AppColors.greenAccent, width: 1.5),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),

  // ✅ نظام الألوان
  colorScheme: const ColorScheme.dark(
    primary: AppColors.greenAccent,
    background: AppColors.background,
    onPrimary: Colors.black,
    onBackground: Colors.white,
  ),
);

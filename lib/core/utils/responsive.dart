import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;

  Responsive(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;

  // ✅ نسب العرض
  double wp(double percent) => screenWidth * percent;
  
  // ✅ نسب الطول
  double hp(double percent) => screenHeight * percent;

  // ✅ حجم الخط النسبي
  double sp(double percent) => screenWidth * percent;

  // ✅ للوصول السريع
  static Responsive of(BuildContext context) => Responsive(context);
}

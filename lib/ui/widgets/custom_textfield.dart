// في ملف custom_textfield.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String iconPath;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onSuffixTap;
  final bool showSuffixIcon;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
    this.controller,
    this.onSuffixTap,
    this.showSuffixIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: r.hp(0.02)),
      decoration: BoxDecoration(
        color: AppColors.inputDark,
        borderRadius: BorderRadius.circular(r.wp(0.03)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: r.wp(0.04),
            vertical: r.hp(0.02),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: r.sp(0.04),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(r.wp(0.025)),
            child: SvgPicture.asset(
              iconPath,
              width: r.wp(0.05),
              height: r.wp(0.05),
              color: Colors.white70,
            ),
          ),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  onPressed: onSuffixTap,
                  icon: SvgPicture.asset(
                    obscureText
                        ? AppImages.eye      // عين مغلقة
                        : AppImages.eye_open, // عين مفتوحة (وفرها ضمن أيقوناتك)
                    color: AppColors.greenAccent,
                    width: r.wp(0.05),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

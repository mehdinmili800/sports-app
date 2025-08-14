import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String iconPath;              // يسمح بالفراغ ""
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
            vertical: r.hp(0.018),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: r.sp(0.038),
          ),
          // ✅ لو المسار فارغ نستخدم أيقونة مدمجة بدل SVG
          prefixIcon: Padding(
            padding: EdgeInsets.all(r.wp(0.025)),
            child: iconPath.isEmpty
                ? Icon(Icons.search, color: Colors.white70, size: r.wp(0.055))
                : SvgPicture.asset(
                    iconPath,
                    width: r.wp(0.05),
                    height: r.wp(0.05),
                    color: Colors.white70,
                  ),
          ),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.greenAccent,
                    size: r.wp(0.055),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

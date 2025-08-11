import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return Container(
      height: r.hp(0.06),
      decoration: BoxDecoration(
        color: AppColors.inputDark,
        borderRadius: BorderRadius.circular(r.wp(0.033)),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenAccent.withOpacity(0.12),
            blurRadius: 16,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: r.sp(0.037),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: r.wp(0.04),
            vertical: r.hp(0.018),
          ),
          hintText: "Search for trainers, sports, or gyms...",
          hintStyle: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: r.sp(0.037),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: r.wp(0.02)),
            child: SvgPicture.asset(
              AppImages.search,
              width: r.wp(0.06),
              height: r.wp(0.06),
              color: AppColors.greenAccent.withOpacity(0.85),
            ),
          ),
        ),
        cursorColor: AppColors.greenAccent,
      ),
    );
  }
}
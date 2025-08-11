import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const SearchWidget({required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return Container(
      height: r.hp(0.055),
      decoration: BoxDecoration(
        color: AppColors.inputDark,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          SizedBox(width: r.wp(0.033)),
          SvgPicture.asset(
            AppImages.search,
            width: 22,
            color: Colors.white60,
          ),
          SizedBox(width: r.wp(0.028)),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: r.sp(0.037)),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: r.sp(0.037),
                ),
              ),
            ),
          ),
          SizedBox(width: r.wp(0.017)),
        ],
      ),
    );
  }
}

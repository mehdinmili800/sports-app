import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class SportChip extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const SportChip({
    Key? key,
    required this.iconPath,
    required this.label,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: r.wp(0.018)),
        padding: EdgeInsets.symmetric(
          horizontal: r.wp(0.042),
          vertical: r.hp(0.013),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.greenAccent.withOpacity(0.16) : AppColors.inputDark,
          borderRadius: BorderRadius.circular(r.wp(0.042)),
          border: Border.all(
            color: isSelected ? AppColors.greenAccent : Colors.white12,
            width: isSelected ? 2.1 : 1,
          ),
          boxShadow: isSelected
          ? [
            BoxShadow(
              color: AppColors.greenAccent.withOpacity(0.12),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ]
          :[],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: r.wp(0.058),
              height: r.wp(0.058),
              color: isSelected ? AppColors.greenAccent : Colors.white70,
            ),
            SizedBox(width: r.wp(0.018)),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? AppColors.greenAccent : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: r.sp(0.035),
              ),
            )
          ],
        ),
      ),
    );
  }
}
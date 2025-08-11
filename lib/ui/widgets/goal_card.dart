import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class GoalCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: r.hp(0.003)), // هامش خفيف فوق وتحت
        padding: EdgeInsets.symmetric(
          vertical: r.hp(0.024),
          horizontal: r.wp(0.008),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.background.withOpacity(0.97)
              : AppColors.inputDark.withOpacity(0.97),
          borderRadius: BorderRadius.circular(r.wp(0.032)),
          border: Border.all(
            color: isSelected
                ? AppColors.greenAccent
                : Colors.white.withOpacity(0.09),
            width: isSelected ? 2.2 : 1.1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.greenAccent.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الأيقونة داخل دائرة خفيفة عند التحديد
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.greenAccent.withOpacity(0.14)
                    : Colors.white.withOpacity(0.04),
              ),
              padding: EdgeInsets.all(r.wp(0.034)),
              child: SvgPicture.asset(
                iconPath,
                width: r.wp(0.079),
                height: r.wp(0.079),
                color: AppColors.greenAccent,
              ),
            ),
            SizedBox(height: r.hp(0.014)),
            // العنوان
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isSelected ? AppColors.greenAccent : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: r.sp(0.041),
                shadows: isSelected
                    ? [
                        Shadow(
                          color: AppColors.greenAccent.withOpacity(0.17),
                          blurRadius: 12,
                        )
                      ]
                    : [],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.hp(0.008)),
            // النص الثانوي
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: isSelected
                    ? AppColors.greenAccent.withOpacity(0.85)
                    : Colors.white54,
                fontSize: r.sp(0.032),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

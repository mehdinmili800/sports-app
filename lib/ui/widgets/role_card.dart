import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class RoleCard extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String image;
  final VoidCallback onTap;
  final IconData icon;
  final Responsive r;
  final bool isLeft;

  const RoleCard({
    required this.isSelected,
    required this.label,
    required this.image,
    required this.onTap,
    required this.icon,
    required this.r,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedScale(
        scale: isSelected ? 1.06 : 0.96,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        child: GestureDetector(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 0.66, // نسبة ذهبية، تناسب أغلب الصور (عدلها حسب صورك)
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: r.wp(0.012),
                vertical: r.hp(0.009),
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          AppColors.greenAccent.withOpacity(0.85),
                          AppColors.greenAccent.withOpacity(0.45),
                          AppColors.background.withOpacity(0.88),
                        ],
                        begin: isLeft ? Alignment.topLeft : Alignment.topRight,
                        end: isLeft ? Alignment.bottomRight : Alignment.bottomLeft,
                      )
                    : null,
                color: isSelected
                    ? null
                    : AppColors.inputDark.withOpacity(0.96),
                borderRadius: BorderRadius.circular(r.wp(0.055)),
                border: Border.all(
                  color: isSelected
                      ? AppColors.greenAccent.withOpacity(0.8)
                      : Colors.white10,
                  width: isSelected ? 2.1 : 1.0,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: AppColors.greenAccent.withOpacity(0.20),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  BoxShadow(
                    color: isSelected
                        ? AppColors.greenAccent.withOpacity(0.06)
                        : Colors.black.withOpacity(0.09),
                    blurRadius: isSelected ? 20 : 10,
                    spreadRadius: 1,
                    offset: Offset(0, isSelected ? 2 : 1),
                  ),
                ],
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // الصورة مع aspectRatio داخلي حتى لا تُقص
                  AspectRatio(
                    aspectRatio: 1, // جرب 1 للصورة المربعة أو عدلها حسب صورة كل بطاقة
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(r.wp(0.042)),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain, // أو BoxFit.cover لو أردت ملء البطاقة
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: r.hp(0.012)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: isSelected ? Colors.white : AppColors.greenAccent,
                        size: r.wp(isSelected ? 0.061 : 0.056),
                      ),
                      SizedBox(width: r.wp(0.012)),
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          color: isSelected ? Colors.white : AppColors.greenAccent,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          fontSize: r.sp(isSelected ? 0.041 : 0.037),
                          shadows: isSelected
                              ? [
                                  Shadow(
                                    color: AppColors.greenAccent.withOpacity(0.17),
                                    blurRadius: 10,
                                  )
                                ]
                              : [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

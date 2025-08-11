import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

// 🟢 عرف المتغيرات هنا
const List<String> _tabNames = [
  "Trainers",
  "Players",
  "Groups",
];

const List<IconData> _tabIcons = [
  Icons.fitness_center,    // مدرب
  Icons.sports_tennis,     // لاعب
  Icons.groups_2_rounded,  // جروب
];

class ModernTabBar extends StatelessWidget {
  final int selected;
  final Responsive r;
  final ValueChanged<int> onChanged;
  const ModernTabBar({required this.selected, required this.r, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: r.hp(0.060),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: BoxDecoration(
        color: AppColors.inputDark.withOpacity(0.94),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10, offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_tabNames.length, (i) {
          final isActive = selected == i;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.ease,
              margin: EdgeInsets.symmetric(horizontal: r.wp(0.008)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.greenAccent.withOpacity(0.19)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.greenAccent.withOpacity(0.21),
                              blurRadius: 18,
                              offset: Offset(0, 5),
                            )
                          ]
                        : [],
                    border: Border.all(
                      color: isActive
                          ? AppColors.greenAccent
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: r.hp(0.011),
                    horizontal: r.wp(0.015),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _tabIcons[i],
                        color: isActive ? AppColors.greenAccent : Colors.white54,
                        size: r.sp(0.035),
                      ),
                      SizedBox(width: r.wp(0.014)),
                      Text(
                        _tabNames[i],
                        style: GoogleFonts.poppins(
                          color: isActive
                              ? AppColors.greenAccent
                              : Colors.white.withOpacity(0.82),
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                          fontSize: r.sp(0.031),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

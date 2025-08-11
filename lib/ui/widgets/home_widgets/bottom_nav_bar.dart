import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    final items = [
      {"icon": AppImages.home, "label": "Home"},
      {"icon": AppImages.notification, "label": "Notification"},
      {"icon": AppImages.booking, "label": "Booking"},
      {"icon": AppImages.message, "label": "Message"},
      {"icon": AppImages.profile, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputDark.withOpacity(0.99),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: r.wp(0.01),
        right: r.wp(0.01),
        top: r.hp(0.01),
        bottom: r.hp(0.01) + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isSelected = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              width: r.wp(0.17),
              padding: EdgeInsets.symmetric(vertical: r.hp(0.002)),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      items[i]['icon']!,
                      width: 22,
                      height: 22,
                      color: isSelected
                          ? AppColors.greenAccent
                          : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    items[i]['label']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.greenAccent
                          : Colors.white54,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 12,
                      height: 1.1,
                      letterSpacing: 0.15,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

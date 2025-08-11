import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/utils/responsive.dart';

// SportsMarketCard صغير ومسطح
class SportsMarketCard extends StatelessWidget {
  final VoidCallback onShopTap;
  const SportsMarketCard({Key? key, required this.onShopTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Container(
      margin: EdgeInsets.only(
        left: r.wp(0.045),
        right: r.wp(0.045),
        top: r.hp(0.014),
        bottom: r.hp(0.010),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: r.wp(0.026),
        vertical: r.hp(0.014),
      ),
      decoration: BoxDecoration(
        color: AppColors.inputDark.withOpacity(0.97),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greenAccent.withOpacity(0.26), width: 1),
      ),
      child: Row(
        children: [
          // صورة أيقونة الماركت
          SvgPicture.asset(
            AppImages.supplements,
            width: r.wp(0.093),
            height: r.wp(0.093),
            fit: BoxFit.contain,
          ),
          SizedBox(width: r.wp(0.024)),
          // نص مختصر
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sports Market",
                  style: GoogleFonts.poppins(
                    color: AppColors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: r.sp(0.033),
                  ),
                ),
                SizedBox(height: r.hp(0.002)),
                Text(
                  "Supplements & Gear",
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.84),
                    fontWeight: FontWeight.w500,
                    fontSize: r.sp(0.027),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: r.wp(0.014)),
          // زر الماركت صغير
          ElevatedButton(
            onPressed: onShopTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greenAccent,
              foregroundColor: Colors.black,
              minimumSize: Size(r.wp(0.07), r.wp(0.07)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Icon(Icons.shopping_cart_outlined, size: r.sp(0.037)),
          ),
        ],
      ),
    );
  }
}

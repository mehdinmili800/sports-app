import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class PromoBanner extends StatelessWidget {
  final Responsive r;
  const PromoBanner({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: r.hp(0.16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF14301b),
            Color(0xFF1D2328),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenAccent.withOpacity(0.09),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          // دائرة توهج خفيفة
          Positioned(
            right: -38,
            top: -28,
            child: Container(
              width: r.wp(0.46),
              height: r.wp(0.46),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenAccent.withOpacity(0.13),
              ),
            ),
          ),
          // نص وعرض وصورة حقيقية
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.wp(0.042), vertical: r.hp(0.02)),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: r.hp(0.005),
                    children: [
                      Text(
                        'Big Sale on\nSupplements',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          height: 1.07,
                          fontSize: r.sp(0.053),
                        ),
                      ),
                      Text(
                        'Up to 40% off',
                        style: GoogleFonts.poppins(
                          color: AppColors.greenAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: r.sp(0.038),
                        ),
                      ),
                    ],
                  ),
                ),
                // هنا صورة المنتج الحقيقية بدل الزخرفة المؤقتة
                Image.asset(
                  AppImages.product_whey, // ضع المسار الصحيح بعد الإضافة
                  width: r.wp(0.19),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class FieldCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String distance;
  final VoidCallback? onTap;

  const FieldCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.distance,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: r.wp(0.38),
        margin: EdgeInsets.only(right: r.wp(0.022)),
        decoration: BoxDecoration(
          color: AppColors.inputDark,
          borderRadius: BorderRadius.circular(r.wp(0.026)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // لا تستخدم max
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(r.wp(0.026))),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: r.hp(0.09), // قللها
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.wp(0.02),
                vertical: r.hp(0.01), // قللها
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: r.sp(0.032), // قلل الخط
                    ),
                  ),
                  SizedBox(height: r.hp(0.003)),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      color: AppColors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: r.sp(0.029),
                    ),
                  ),
                  SizedBox(height: r.hp(0.001)),
                  Text(
                    distance,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: r.sp(0.022),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
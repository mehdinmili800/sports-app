import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class TrainerCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String sport;
  final double rating;
  final String price;
  final String distance;
  final bool isCertified;
  final String status;
  final VoidCallback? onTap;

  const TrainerCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.sport,
    required this.rating,
    required this.price,
    required this.distance,
    required this.isCertified,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: r.hp(0.015)),
        decoration: BoxDecoration(
          color: AppColors.inputDark.withOpacity(0.98),
          borderRadius: BorderRadius.circular(r.wp(0.032)),
          boxShadow: [
            BoxShadow(
              color: AppColors.greenAccent.withOpacity(0.08),
              blurRadius: 14, spreadRadius: 1, offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المدرب
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(r.wp(0.032)),
                bottomLeft: Radius.circular(r.wp(0.032)),
              ),
              child: Image.asset(
                imagePath,
                width: r.wp(0.21),
                height: r.hp(0.12),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: r.wp(0.028)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: r.hp(0.014), horizontal: r.wp(0.012)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المدرب
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: r.sp(0.037),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // نوع الرياضة
                    Text(
                      sport,
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                        fontSize: r.sp(0.027),
                      ),
                    ),
                    SizedBox(height: r.hp(0.005)),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: AppColors.greenAccent, size: r.sp(0.030)),
                        SizedBox(width: r.wp(0.006)),
                        Text(
                          rating.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            color: AppColors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: r.sp(0.029),
                          ),
                        ),
                        SizedBox(width: r.wp(0.012)),
                        Text(
                          price,
                          style: GoogleFonts.poppins(
                            color: AppColors.greenAccent,
                            fontWeight: FontWeight.w700,
                            fontSize: r.sp(0.029),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: r.hp(0.007)),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isCertified
                                ? AppColors.greenAccent.withOpacity(0.12)
                                : Colors.white10,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            isCertified ? "Certified" : "No Certified",
                            style: GoogleFonts.poppins(
                              color: isCertified ? AppColors.greenAccent : Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: r.sp(0.023),
                            ),
                          ),
                        ),
                        SizedBox(width: r.wp(0.015)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.greenAccent.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.poppins(
                              color: AppColors.greenAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: r.sp(0.021),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: r.hp(0.006)),
                    Text(
                      distance,
                      style: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontSize: r.sp(0.021),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

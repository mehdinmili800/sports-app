import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';

class TrainerCardExact extends StatelessWidget {
  final String name;
  final String subtitle;
  final String priceText;
  final String distance;
  final ImageProvider? image;
  final bool compact;

  const TrainerCardExact({
    super.key,
    required this.name,
    required this.subtitle,
    required this.priceText,
    required this.distance,
    this.image,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    const blueCard = Color(0xFF223044);
    const blueBorder = Color(0xFF2A2F38);

    final cardH = compact ? 100.0 : 128.0;
    final img = compact ? 60.0 : 80.0;
    final titleFs = compact ? 14.0 : 16.5;
    final subFs = compact ? 10.0 : 12.0;
    final lineFs = compact ? 10.0 : 12.0;
    final chipFs = compact ? 9.0 : 10.5;
    final iconSz = compact ? 13.0 : 15.0;
    final gap1 = compact ? 4.0 : 6.0;
    final gap2 = compact ? 4.0 : 8.0;

    return Container(
      height: cardH,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: blueCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: blueBorder),
      ),
      child: Row(
        children: [
          // صورة مربعة أو مستطيلة كما كانت
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // حواف ناعمة
            child: Container(
              width: img,
              height: img,
              color: Colors.white10,
              child: image != null
                  ? Image(image: image!, fit: BoxFit.cover) // تغطي الإطار بالكامل
                  : const Icon(Icons.person, size: 28, color: Colors.white70),
            ),
          ),
          const SizedBox(width: 10),

          // النصوص
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: titleFs,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: subFs,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: gap1),
                Row(
                  children: [
                    Icon(Icons.star,
                        size: iconSz, color: AppColors.greenAccent),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        priceText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: lineFs,
                          height: 1.05,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap2),
                Flexible(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 3,
                    children: [
                      _badge('Certified', chipFs),
                      _badge('A.today', chipFs),
                      Text(
                        distance,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: chipFs,
                          height: 1.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _badge(String t, double fs) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3F47),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          t,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: fs,
            fontWeight: FontWeight.w600,
            height: 1.05,
          ),
        ),
      );
}

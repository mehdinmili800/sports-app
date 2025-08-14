import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';

class OfferCardExact extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool compact; // <-- جديد

  const OfferCardExact({
    required this.title,
    required this.icon,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final titleFs = compact ? 12.5 : 14.5;
    final iconSz = compact ? 38.0 : 44.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // نص أصغر قليلًا
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: titleFs,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),
        const Spacer(),
        Icon(icon, size: iconSz, color: AppColors.greenAccent),
      ],
    );
  }
}

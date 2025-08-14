import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/data/models/sport.dart';

class SportTile extends StatelessWidget {
  final Sport s;
  const SportTile({required this.s});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121619),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greenAccent.withOpacity(.35)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(s.icon, color: AppColors.greenAccent, size: 24),
          const SizedBox(height: 6),
          Text(s.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}
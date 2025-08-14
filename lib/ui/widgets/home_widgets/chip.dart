import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';

class Chip extends StatelessWidget {
  final String text;
  const Chip({required this.text});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF121619),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(text,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
      );
}
// --- زجاجة مؤقتة كعنصر زخرفي للمنتج ---
// استبدلها لاحقاً بصورة المنتج الحقيقية (PNG أو SVG)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';

class BottleMock extends StatelessWidget {
  final double width;
  final String label;
  const BottleMock({required this.width, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, height: width * 1.26,
      child: Column(
        children: [
          // الغطاء
          Container(
            width: width * 0.62, height: width * 0.17,
            decoration: BoxDecoration(
              color: const Color(0xFF181C20),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white12),
            ),
          ),
          const SizedBox(height: 3),
          // الجسم
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF181C20), Color(0xFF111417)],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greenAccent.withOpacity(0.13),
                    blurRadius: 9, offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.93),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: width * 0.20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          // شريط أخضر
          Container(
            width: width * 0.95, height: 4,
            decoration: BoxDecoration(
              color: AppColors.greenAccent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
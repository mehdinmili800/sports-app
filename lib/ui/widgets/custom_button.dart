import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // ✅ يجب أن يقبل null
  final bool isFilled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return SizedBox(
      width: double.infinity,
      height: r.hp(0.065),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? Colors.greenAccent : Colors.transparent,
          foregroundColor: isFilled ? Colors.black : Colors.greenAccent,
          elevation: 0,
          side: isFilled
              ? null
              : const BorderSide(color: Colors.greenAccent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.wp(0.02)),
          ),
        ),
        onPressed: onPressed, // ✅ الآن يقبل null بدون خطأ
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: r.sp(0.045),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

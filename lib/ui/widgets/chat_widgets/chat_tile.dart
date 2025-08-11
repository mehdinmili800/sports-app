import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/screens/message/message_screen.dart';

class ChatTile extends StatelessWidget {
  final ChatMessage msg;
  final Responsive r;
  final VoidCallback? onTap;

  const ChatTile({Key? key, required this.msg, required this.r, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,  // أضف هنا الـ onTap للتنقل للشات
      child: Container(
        margin: EdgeInsets.symmetric(vertical: r.hp(0.004)),
        padding: EdgeInsets.all(r.wp(0.03)),
        decoration: BoxDecoration(
          color: AppColors.inputDark,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(r.wp(0.07)),
              child: Image.asset(
                msg.avatar,
                width: r.wp(0.14),
                height: r.wp(0.14),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: r.wp(0.034)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: r.sp(0.034),
                    ),
                  ),
                  SizedBox(height: r.hp(0.003)),
                  Text(
                    msg.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.72),
                      fontSize: r.sp(0.028),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: r.wp(0.025)),
            Text(
              msg.time,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.54),
                fontSize: r.sp(0.023),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/core/constants/images.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    // بيانات الإشعارات
    final notifications = [
      {
        "icon": AppImages.booking,
        "title": "Booking Confirmed",
        "time": "5 mins ago",
        "body": "You have a session with Coach Kareem scheduled for tomorrow at 10:00 AM",
      },
      {
        "icon": AppImages.message,
        "title": "New Message from ALi Mansoor",
        "time": "5 mins ago",
        "body": "You have a session with Coach Kareem scheduled for tomorrow at 10:00 AM",
      },
      {
        "icon": AppImages.message,
        "title": "New Message from Ramos Edirson",
        "time": "30 mins ago",
        "body": "You have a session with Coach Kareem scheduled for tomorrow at 10:00 AM",
      },
      {
        "icon": AppImages.booking,
        "title": "Booking Confirmed",
        "time": "1h ago",
        "body": "You have a session with Coach Kareem scheduled for tomorrow at 10:00 AM",
      },
      {
        "icon": AppImages.message,
        "title": "New Message from Ali Mansoor",
        "time": "4h ago",
        "body": "You have a session with Coach Kareem scheduled for tomorrow at 10:00 AM",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: EdgeInsets.fromLTRB(r.wp(0.02), r.hp(0.006), r.wp(0.02), r.hp(0.018)),
              child: Row(
                children: [
                  
                  Expanded(
                    child: Center(
                      child: Text(
                        "Notifications",
                        style: GoogleFonts.poppins(
                          color: AppColors.greenAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: r.sp(0.052),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 36), // تعويض السهم
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: r.wp(0.018)),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => SizedBox(height: r.hp(0.018)),
                itemBuilder: (context, i) {
                  final n = notifications[i];
                  return _NotificationCard(
                    icon: n["icon"]!,
                    title: n["title"]!,
                    time: n["time"]!,
                    body: n["body"]!,
                    r: r,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card notification widget مع تأثيرات جميلة
class _NotificationCard extends StatelessWidget {
  final String icon, title, time, body;
  final Responsive r;

  const _NotificationCard({
    required this.icon,
    required this.title,
    required this.time,
    required this.body,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: AppColors.greenAccent.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Soon: Details & Actions"),
          behavior: SnackBarBehavior.floating,
        ));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: const Color(0xFF222C38).withOpacity(0.93),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.greenAccent.withOpacity(0.65),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greenAccent.withOpacity(0.05),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
            r.wp(0.035), r.hp(0.019), r.wp(0.03), r.hp(0.017)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // مباشرة الأيقونة بدون خلفية إضافية
            SvgPicture.asset(
              icon,
              width: r.wp(0.072),
              height: r.wp(0.072),
              color: AppColors.greenAccent,
            ),
            SizedBox(width: r.wp(0.037)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: r.sp(0.037),
                      letterSpacing: 0.15,
                    ),
                  ),
                  SizedBox(height: r.hp(0.004)),
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: r.sp(0.028),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.10,
                    ),
                  ),
                  SizedBox(height: r.hp(0.008)),
                  Text(
                    body,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.94),
                      fontSize: r.sp(0.031),
                      fontWeight: FontWeight.w400,
                      height: 1.3,
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
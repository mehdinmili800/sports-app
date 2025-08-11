// بطاقة الحجز
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/screens/booking/booking_screen.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final Responsive r;
  const BookingCard({
    Key? key,
    required this.booking,
    required this.r,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusColor = booking.status == "confirmed"
        ? AppColors.greenAccent
        : Colors.white.withOpacity(0.85);
    final statusBg = booking.status == "confirmed"
        ? Colors.transparent
        : AppColors.inputDark;
    final statusText =
        booking.status == "confirmed" ? "confirmed" : "pending Approval";
    final borderColor = booking.status == "confirmed"
        ? AppColors.greenAccent
        : Colors.transparent;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.inputDark,
        borderRadius: BorderRadius.circular(16),
      ),
      padding:
          EdgeInsets.symmetric(vertical: r.hp(0.021), horizontal: r.wp(0.038)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الاسم + حالة الحجز
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.coach,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: r.sp(0.037),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: r.wp(0.038), vertical: r.hp(0.007)),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor,
                    width: 1.3,
                  ),
                  boxShadow: [
                    if (booking.status == "pending")
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                  ],
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.poppins(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: r.sp(0.028),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.hp(0.008)),
          Text(
            booking.date,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.88),
              fontWeight: FontWeight.w400,
              fontSize: r.sp(0.031),
            ),
          ),
          Text(
            booking.time,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.79),
              fontWeight: FontWeight.w400,
              fontSize: r.sp(0.028),
            ),
          ),
          SizedBox(height: r.hp(0.002)),
          Text(
            booking.location,
            style: GoogleFonts.poppins(
              color: AppColors.greenAccent,
              fontWeight: FontWeight.w500,
              fontSize: r.sp(0.029),
            ),
          ),
        ],
      ),
    );
  }
}

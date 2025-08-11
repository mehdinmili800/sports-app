import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/booking_widgets/booking_card.dart';

class Booking {
  final String coach;
  final String date;
  final String time;
  final String location;
  final String status; // "confirmed", "pending"
  Booking(this.coach, this.date, this.time, this.location, this.status);
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<String> categories = ["All", "Tennis", "Gym", "Kickboxing"];
  int selectedCategory = 0;

  final List<Booking> allBookings = [
    Booking("Coach Michael", "May 28, 2025", "3:00 PM - 4:00 PM", "Kickboxing Gym", "confirmed"),
    Booking("Ramos Edirson", "May 18, 2025", "12:00 PM - 13:00 PM", "Tennis", "pending"),
    Booking("Kovazitch Iron", "May 12, 2024", "6:00 PM - 7:00 PM", "Kickboxing Gym", "confirmed"),
    Booking("Amber Ross", "May 08, 2025", "9:00 PM - 10:00 PM", "Gym", "confirmed"),
    Booking("Yassin Chatab", "May 2, 2025", "12:00 PM - 13:00 PM", "Tennis", "pending"),
  ];

  // تصفية الحجوزات بناءً على الفئة
  List<Booking> get filteredBookings {
    if (selectedCategory == 0) return allBookings;
    final cat = categories[selectedCategory].toLowerCase();
    return allBookings.where((b) => b.location.toLowerCase().contains(cat)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: r.wp(0.05), // فراغ جانبي مرن
            vertical: r.hp(0.01),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: r.hp(0.024)),
              Text(
                'Bookings',
                style: GoogleFonts.poppins(
                  color: AppColors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: r.sp(0.055),
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: r.hp(0.018)),
              // شريط الفئات مع ظل خفيف
              Container(
                height: r.hp(0.056),
                margin: EdgeInsets.symmetric(vertical: r.hp(0.012)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.inputDark.withOpacity(0.87),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8, offset: Offset(0, 2),
                    )
                  ],
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: r.wp(0.018)),
                  itemBuilder: (context, i) {
                    final selected = selectedCategory == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => setState(() => selectedCategory = i),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: r.wp(0.045), vertical: r.hp(0.009)),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.greenAccent.withOpacity(0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: selected
                                  ? AppColors.greenAccent
                                  : Colors.transparent,
                              width: selected ? 1.2 : 0.4,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[i],
                              style: GoogleFonts.poppins(
                                color: selected
                                    ? AppColors.greenAccent
                                    : Colors.white.withOpacity(0.84),
                                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                                fontSize: r.sp(0.034),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: r.hp(0.020)),
              // قائمة الحجوزات
              Expanded(
                child: filteredBookings.isEmpty
                    ? Center(
                        child: Text(
                          "No bookings found for this category.",
                          style: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: r.sp(0.038),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(bottom: r.hp(0.012)),
                        itemCount: filteredBookings.length,
                        separatorBuilder: (_, __) => SizedBox(height: r.hp(0.018)),
                        itemBuilder: (context, i) {
                          final b = filteredBookings[i];
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 240),
                            child: BookingCard(
                              key: ValueKey(b.hashCode),
                              booking: b,
                              r: r,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      // يمكنك إضافة BottomNavigationBar هنا إذا كان ضمن تصميمك
    );
  }
}

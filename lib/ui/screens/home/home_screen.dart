// lib/ui/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/ui/widgets/home_widgets/bottom_nav_bar.dart';

// استورد الشاشات:
import 'home_main_screen.dart';
import 'package:hanae_app/ui/screens/booking/booking_screen.dart';
import 'package:hanae_app/ui/screens/message/message_screen.dart';
import 'package:hanae_app/ui/screens/notifications/notifications_screen.dart';
import 'package:hanae_app/ui/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNav = 0;

  final List<Widget> screens = const [
    HomeMainScreen(),
    NotificationsScreen(),
    BookingScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: selectedNav,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedNav,
        onTap: (i) => setState(() => selectedNav = i),
      ),
    );
  }
}

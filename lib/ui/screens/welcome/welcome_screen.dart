import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(0.08)),
          child: Column(
            children: [
              SizedBox(height: r.hp(0.05)),

              // ✅ شعار نيون متوهج متحرك
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(r.wp(0.02)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(_glowAnimation.value),
                            blurRadius: r.wp(3.0),
                            spreadRadius: r.wp(0.8),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        AppImages.logo,
                        width: r.wp(0.28),
                        height: r.wp(0.28),
                        color: Colors.greenAccent,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: r.hp(0.04)),

              Text(
                "Welcome to",
                style: GoogleFonts.poppins(
                  fontSize: r.sp(0.045),
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: r.hp(0.01)),

              Text(
                "Sports Booking",
                style: GoogleFonts.poppins(
                  fontSize: r.sp(0.06),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              // ✅ زر الضيف
              SizedBox(
                width: double.infinity,
                height: r.hp(0.065),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.greenAccent, width: 1.5),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Browse as Guest",
                    style: GoogleFonts.poppins(fontSize: r.sp(0.045)),
                  ),
                ),
              ),

              SizedBox(height: r.hp(0.02)),

              // ✅ زر الدخول
              SizedBox(
                width: double.infinity,
                height: r.hp(0.065),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: r.sp(0.045),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: r.hp(0.04)),
            ],
          ),
        ),
      ),
    );
  }
}

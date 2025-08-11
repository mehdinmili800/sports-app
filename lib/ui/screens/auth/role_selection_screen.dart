import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/custom_button.dart';
import 'package:hanae_app/ui/widgets/role_card.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  String selectedRole = 'player';

  // إضافة متحكم الأنيميشن والمتغيرات
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

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.06).animate(
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(0.06)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: r.hp(0.04)),
                  // ⭐⭐ هنا شعار متحرك بنفس الأنيميشن
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
                                color: Colors.greenAccent
                                    .withOpacity(_glowAnimation.value),
                                blurRadius: r.wp(3.0),
                                spreadRadius: r.wp(0.6),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            AppImages.logo,
                            width: r.wp(0.23),
                            height: r.wp(0.23),
                            color: Colors.greenAccent,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: r.hp(0.045)),
                  Text(
                    "Choose who you are ?",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: r.sp(0.053),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: r.hp(0.06)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoleCard(
                        isSelected: selectedRole == 'coach',
                        label: "Coach",
                        image: AppImages.coach,
                        onTap: () => setState(() => selectedRole = 'coach'),
                        icon: Icons.person,
                        r: r,
                        isLeft: true,
                      ),
                      SizedBox(width: r.wp(0.05)), // تباعد مناسب بين البطاقتين
                      RoleCard(
                        isSelected: selectedRole == 'player',
                        label: "Player",
                        image: AppImages.player,
                        onTap: () => setState(() => selectedRole = 'player'),
                        icon: Icons.person,
                        r: r,
                        isLeft: false,
                      ),
                    ],
                  ),
                  SizedBox(height: r.hp(0.08)),
                  CustomButton(
                    text: "Confirm",
                    onPressed: () {
                      // Use selectedRole for next action
                      Get.toNamed(AppRoutes.fitnessGoal); 
                    },
                  ),
                  SizedBox(height: r.hp(0.03)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

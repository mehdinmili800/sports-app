import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/custom_button.dart';
import 'package:hanae_app/ui/widgets/goal_card.dart'; // سنضيف هذا الملف لاحقًا

class FitnessGoalScreen extends StatefulWidget {
  const FitnessGoalScreen({super.key});

  @override
  State<FitnessGoalScreen> createState() => _FitnessGoalScreenState();
}

class _FitnessGoalScreenState extends State<FitnessGoalScreen>
    with SingleTickerProviderStateMixin {
  int selectedGoal = 1; // 0: Lose Weight, 1: Build Muscle, 2: Get Fitter

  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.97, end: 1.05).animate(
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
                  SizedBox(height: r.hp(0.05)),
                  // لوجو متحرك
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: EdgeInsets.all(r.wp(0.018)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent.withOpacity(_glowAnimation.value),
                                blurRadius: r.wp(3.3),
                                spreadRadius: r.wp(0.7),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            AppImages.logo,
                            width: r.wp(0.22),
                            height: r.wp(0.22),
                            color: Colors.greenAccent,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: r.hp(0.045)),
                  Text(
                    "What's your main\nfitness goal?",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: r.sp(0.052),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.hp(0.055)),

                  // خيارات الأهداف (3 بطاقات أفقية)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GoalCard(
                          iconPath: AppImages.lose_weight,
                          title: "Lose Weight",
                          subtitle: "Focus on fat burning",
                          isSelected: selectedGoal == 0,
                          onTap: () => setState(() => selectedGoal = 0),
                        ),
                      ),
                      SizedBox(width: r.wp(0.018)),
                      Expanded(
                        child: GoalCard(
                          iconPath: AppImages.build_muscle,
                          title: "Build Muscle",
                          subtitle: "Focus on Builds",
                          isSelected: selectedGoal == 1,
                          onTap: () => setState(() => selectedGoal = 1),
                        ),
                      ),
                      SizedBox(width: r.wp(0.018)),
                      Expanded(
                        child: GoalCard(
                          iconPath: AppImages.get_fitter,
                          title: "Get Fitter",
                          subtitle: "Focus on health",
                          isSelected: selectedGoal == 2,
                          onTap: () => setState(() => selectedGoal = 2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.hp(0.13)),
                  CustomButton(
                    text: "Next",
                    onPressed: () {
                      Get.toNamed(AppRoutes.home); 

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

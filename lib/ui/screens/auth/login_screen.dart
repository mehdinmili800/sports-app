import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/custom_button.dart';
import 'package:hanae_app/ui/widgets/custom_textfield.dart';
import 'package:hanae_app/ui/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: r.wp(0.08)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: r.hp(0.05)),

              // ✅ شعار LED متوهج متحرك
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
                        width: r.wp(0.28),
                        height: r.wp(0.28),
                        color: Colors.greenAccent,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: r.hp(0.03)),

              Text(
                "Log in to your account",
                style: GoogleFonts.poppins(
                  fontSize: r.sp(0.045),
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: r.hp(0.04)),

              CustomTextField(
                hintText: "Email",
                iconPath: AppImages.emailIcon,
                controller: emailController,
              ),

              SizedBox(height: r.hp(0.025)),

              CustomTextField(
                hintText: "Password",
                iconPath: AppImages.passwordIcon,
                controller: passwordController,
                obscureText: true,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: r.sp(0.035),
                    ),
                  ),
                ),
              ),

              SizedBox(height: r.hp(0.04)),

              CustomButton(
                text: "Login",
                onPressed: () {
                  Get.snackbar(
                    "Login",
                    "Logging in...",
                    backgroundColor: Colors.green,
                    colorText: Colors.black,
                    duration: const Duration(seconds: 2), // مدة ظهور الرسالة
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Get.toNamed(AppRoutes.roleSelection); 
                  });
                },
              ),

              SizedBox(height: r.hp(0.03)),

              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.register),
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: r.sp(0.04),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "or",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: r.sp(0.035),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              SizedBox(height: r.hp(0.025)),

              SocialButton(
                icon: AppImages.googleIcon,
                text: "Sign up with Google",
                onTap: () {
                  Get.toNamed(AppRoutes.roleSelection); 
                },
              ),

              SizedBox(height: r.hp(0.015)),

              SocialButton(
                icon: AppImages.appleIcon,
                text: "Sign up with Apple",
                onTap: () {
                  Get.toNamed(AppRoutes.roleSelection); 
                },
              ),

              SizedBox(height: r.hp(0.04)),
            ],
          ),
        ),
      ),
    );
  }
}

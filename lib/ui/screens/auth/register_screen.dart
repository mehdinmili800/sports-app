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
import 'package:hanae_app/ui/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  

  bool isTrainer = true;

  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool agreeToTerms = false;
  

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
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: r.wp(0.06)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: r.hp(0.06)),
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
              SizedBox(height: r.hp(0.04)),
              Text(
                'Create your account',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: r.sp(0.055),
                  fontWeight: FontWeight.w500,
                ),

                // Email
              ),
              SizedBox(height: r.hp(0.045)),
              CustomTextField(
                hintText: "Email",
                iconPath: AppImages.emailIcon,
                controller: _emailController,
              ),

              // Password
              CustomTextField(
                hintText: "Password",
                iconPath: AppImages.passwordIcon,
                obscureText: obscurePassword,
                controller: _passwordController,
                onSuffixTap: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                showSuffixIcon: true,
              ),

              // Password Confirmation
              CustomTextField(
                hintText: "Password confirmation",
                iconPath: AppImages.passwordIcon,
                obscureText: obscureConfirmPassword,
                controller: _confirmPasswordController,
                onSuffixTap: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
                showSuffixIcon: true,
              ),

              // Phone Number
              CustomTextField(
                hintText: "Phone Number",
                iconPath: AppImages.phone,
                controller: _phoneController,
              ),

              SizedBox(height: r.hp(0.035)),

              // ✅ Checkbox للموافقة على القوانين
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: AppColors.greenAccent,
                    checkColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: const BorderSide(
                        color: AppColors.greenAccent, width: 1.3),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: يمكنك فتح صفحة الشروط هنا
                        // Get.toNamed(AppRoutes.terms); // أو أي Route عندك
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree to the ',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: r.sp(0.035),
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: GoogleFonts.poppins(
                                color: AppColors.greenAccent,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: r.sp(0.035),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: r.hp(0.04)),

              // Create Account Button
              CustomButton(
                text: "Create Account",
                onPressed: agreeToTerms
                    ? () {
                      Get.toNamed(AppRoutes.roleSelection); 
                      }
                    : null,
                isFilled: true,
              ),

              SizedBox(height: r.hp(0.04)),

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

              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: r.sp(0.04),
                    ),
                  ),
                ),
              ),

              SizedBox(height: r.hp(0.025)),
            ],
          ),
        ),
      ),
    );
  }
}

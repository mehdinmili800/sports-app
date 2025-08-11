import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/widgets/custom_button.dart';
import 'package:hanae_app/ui/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

// ✅ لاحظ مكان with SingleTickerProviderStateMixin
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  bool isLoading = false;

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
    _emailController.dispose();
    super.dispose();
  }

  void _sendReset() async {
    setState(() => isLoading = true);

    // هنا تضع كود ارسال رابط اعادة التعيين (Firebase أو API)
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);
    // ثم تظهر رسالة تنبيه بنجاح الارسال (مثلاً):
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Check your email"),
        content: const Text(
            "A password reset link has been sent to your email address."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: r.wp(0.07)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: r.hp(0.09)),
                // شعار التطبيق (متوهج متحرك)
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
                SizedBox(height: r.hp(0.05)),
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontSize: r.sp(0.055),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.hp(0.015)),
                Text(
                  "Enter your email address below and we'll send you a link to reset your password.",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: r.sp(0.038),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.hp(0.045)),
                CustomTextField(
                  hintText: "Email",
                  iconPath: AppImages.emailIcon,
                  controller: _emailController,
                ),
                SizedBox(height: r.hp(0.01)),
                CustomButton(
                  text: isLoading ? "Please wait..." : "Send Reset Link",
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_emailController.text.trim().isNotEmpty) {
                            _sendReset();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter your email."),
                              ),
                            );
                          }
                        },
                  isFilled: true,
                ),
                SizedBox(height: r.hp(0.025)),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back to Login",
                    style: GoogleFonts.poppins(
                      color: AppColors.greenAccent,
                      fontSize: r.sp(0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

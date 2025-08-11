import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    return SizedBox(
      width: double.infinity,
      height: r.hp(0.065),
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
        ),
        icon: SvgPicture.asset(icon, width: r.wp(0.06)),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: r.sp(0.04),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

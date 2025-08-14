// trainer_row.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/ui/widgets/home_widgets/trainer_card_exact.dart';

class TrainerRow extends StatelessWidget {
  final bool isNarrow;
  final String offerTitle;
  final String offerIconSvg;

  // ✅ صورة المدرّب
  final ImageProvider trainerImage;

  const TrainerRow({
    super.key,
    required this.isNarrow,
    required this.offerTitle,
    required this.offerIconSvg,
    required this.trainerImage,
  });

  @override
  Widget build(BuildContext context) {
    const blueCard = Color(0xFF223044);
    final compact = MediaQuery.of(context).size.width <= 420;

    final trainer = TrainerCardExact(
      name: 'Kovazitch Iron',
      subtitle: 'kickboxing',
      priceText: '4.8  AED 200 / hour',
      distance: '1.5 km away',
      compact: compact,
      image: trainerImage, // 👈 تمرير الصورة هنا
    );

    final offerCard = _OfferTopTitleIconCard(
      title: offerTitle,
      svgPath: offerIconSvg,
      width: compact ? 114 : 124,
      height: compact ? 112 : 132,
      bg: blueCard,
      border: Colors.transparent,
      active: false,
      iconBoxSize: compact ? 56 : 64,
      iconSize: compact ? 30 : 34,
      iconBg: const Color(0xFF0F1620),
      titleFontSize: compact ? 10 : 14,
    );

    if (isNarrow) {
      return Column(children: [trainer, const SizedBox(height: 10), offerCard]);
    }
    return Row(children: [
      Expanded(child: trainer),
      const SizedBox(width: 12),
      offerCard
    ]);
  }
}

class _OfferTopTitleIconCard extends StatelessWidget {
  final String title;
  final String svgPath;
  final double width;
  final double height;
  final Color bg;
  final Color border;
  final bool active;
  final double iconBoxSize;
  final double iconSize;
  final Color iconBg;
  final double titleFontSize;

  const _OfferTopTitleIconCard({
    required this.title,
    required this.svgPath,
    required this.width,
    required this.height,
    required this.bg,
    required this.border,
    this.active = false,
    this.iconBoxSize = 60,
    this.iconSize = 32,
    this.iconBg = const Color(0xFF111820),
    this.titleFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    const kPrimary = Color(0xFF22C55E);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: active
            ? [
                BoxShadow(
                    color: kPrimary.withOpacity(0.22),
                    blurRadius: 18,
                    offset: const Offset(0, 6))
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1, // 👈 نجبره على سطر واحد إن أردت
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: titleFontSize + 2, // 👈 تكبير النص
                fontWeight: FontWeight.w900, // 👈 جعله سميك أكثر
                shadows: const [
                  Shadow(
                      color: Colors.black54,
                      blurRadius: 2,
                      offset: Offset(0, 1)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: iconBoxSize,
            height: iconBoxSize,
            child: SvgPicture.asset(
              svgPath,
              colorFilter: const ColorFilter.mode(kPrimary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

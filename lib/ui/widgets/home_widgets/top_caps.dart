/* ======================= Widgets ======================= */

/* ===================== TopCaps (أصغر) ===================== */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';

/// كبسولات أعلى الهوم باستخدام أصول (SVG/PNG)
class TopCaps extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;
  const TopCaps({super.key, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // استبدل الأيقونات حسب تفضيلك
    final items = <(_AssetIcon, String)>[
      // Trainers: استخدمت أيقونة يوغا كرمز مدرب (غيّرها متى شئت)
      (_AssetIcon(AppImages.coach1), 'Trainers'),
      // Fields: استخدمت كرة القدم كرمز للملاعب
      (_AssetIcon(AppImages.fields), 'Fields'),
      // Proteins: أحد أيقونات المكملات
      (_AssetIcon(AppImages.supplements4), 'Proteins'),
      // Sports Store: أيقونة المتجر
      (_AssetIcon(AppImages.market), 'Sports Store'),
    ];

    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final active = i == selected;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: active
                      ? AppColors.greenAccent.withOpacity(.45)
                      : AppColors.border,
                  width: active ? 1.3 : 1,
                ),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColors.greenAccent.withOpacity(.18),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _IconAsset(
                    items[i].$1.path,
                    size: 40,
                    // لو SVG نلوّنه بالأخضر عند التفعيل وإلا أبيض
                    svgColor: active ? AppColors.greenAccent : Colors.white,
                    // للصور النقطية (PNG) نخليها كما هي أو لو تبغى تلوين، قولّي
                    tintRaster: active ? AppColors.greenAccent : null,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    items[i].$2,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// مجرد حامل مسار
class _AssetIcon {
  final String path;
  const _AssetIcon(this.path);
}

/// ويدجت صغيرة تعرض SVG أو صورة عادية حسب الامتداد
class _IconAsset extends StatelessWidget {
  final String path;
  final double size;
  final Color? svgColor;
  final Color? tintRaster; // لتلوين PNG اختياري

  const _IconAsset(
    this.path, {
    required this.size,
    this.svgColor,
    this.tintRaster,
  });

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter:
            svgColor != null ? ColorFilter.mode(svgColor!, BlendMode.srcIn) : null,
      );
    } else {
      // PNG/JPG
      final img = Image.asset(path, width: size, height: size, fit: BoxFit.contain);
      if (tintRaster == null) return img;
      // تلوين اختياري للصور النقطية إن لزم
      return ColorFiltered(
        colorFilter: ColorFilter.mode(tintRaster!, BlendMode.srcIn),
        child: img,
      );
    }
  }
}

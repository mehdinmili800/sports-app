import 'package:flutter/material.dart';
import 'package:hanae_app/core/constants/themes.dart';

class HeroBanner extends StatelessWidget {
  /// صورة الإعلان (إلزامية)
  final ImageProvider productImage;

  /// حدث الضغط على زر الشراء
  final VoidCallback? onBuy;

  /// ارتفاع البانر (لا نكبره؛ افتراضي 96)
  final double height;

  /// حجم زر الشراء الدائري
  final double buyButtonSize;

  /// أيقونة الشراء
  final IconData buyIcon;

  const HeroBanner({
    super.key,
    required this.productImage,
    this.onBuy,
    this.height = 96,
    this.buyButtonSize = 40,
    this.buyIcon = Icons.shopping_bag_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height, maxHeight: height),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF0F261A), Color(0xFF0B1A12)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greenAccent.withOpacity(.14),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // الصورة تملأ البانر بالكامل
            Positioned.fill(
              child: Image(image: productImage, fit: BoxFit.cover),
            ),

            // زر شراء عائم صغير — أيقونة فقط
            Positioned(
              right: 10,
              bottom: 10,
              child: SizedBox(
                width: buyButtonSize,
                height: buyButtonSize,
                child: Material(
                  color: AppColors.greenAccent,
                  shape: const CircleBorder(),
                  elevation: 0,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onBuy,
                    child: Icon(
                      buyIcon,
                      size: buyButtonSize * 0.55,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // حافة خفيفة لقراءة أفضل على خلفيات فاتحة جداً
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

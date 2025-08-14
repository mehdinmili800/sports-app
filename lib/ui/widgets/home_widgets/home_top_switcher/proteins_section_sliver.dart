import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';

class ProteinsSectionSliver extends StatefulWidget {
  const ProteinsSectionSliver({super.key});

  @override
  State<ProteinsSectionSliver> createState() => _ProteinsSectionSliverState();
}

class _ProteinsSectionSliverState extends State<ProteinsSectionSliver> {
  // تصنيفات واضحة للمستخدم
  final List<String> _categories = const [
    'All',
    'Bulking',      // تضخيم
    'Cutting',      // تنشيف
    'Endurance',    // تحمّل
    'Recovery',     // استشفاء
    'Vegan',
    'Whey',
    'Casein',
    'Creatine',
    'Amino',
    'Pre-Workout',
    'Vitamins',
  ];

  int _selected = 0;

  // بيانات تجريبية: غيّر الصور/الأسعار والأصناف حسب حاجتك
  late final List<_Product> _all = [
    _Product('Whey Isolate 1kg',     'AED 120', [ 'All','Bulking','Whey','Recovery' ], AppImages.product_whey),
    _Product('Whey Concentrate 2kg', 'AED 190', [ 'All','Bulking','Whey' ],           AppImages.product_whey),
    _Product('Casein 1kg',           'AED 140', [ 'All','Recovery','Casein' ],        AppImages.product_whey),
    _Product('Creatine Monohydrate', 'AED 85',  [ 'All','Bulking','Creatine' ],       AppImages.product_whey),
    _Product('BCAA Amino 2:1:1',     'AED 75',  [ 'All','Amino','Recovery' ],         AppImages.product_whey),
    _Product('Pre-Workout 300g',     'AED 110', [ 'All','Pre-Workout','Endurance' ],  AppImages.product_whey),
    _Product('Vegan Protein 1kg',    'AED 150', [ 'All','Vegan','Cutting','Recovery'],AppImages.product_whey),
    _Product('Multivitamin',         'AED 60',  [ 'All','Vitamins','Recovery' ],      AppImages.product_whey),
    _Product('Electrolytes',         'AED 55',  [ 'All','Endurance','Recovery' ],     AppImages.product_whey),
    _Product('L-Carnitine',          'AED 95',  [ 'All','Cutting' ],                  AppImages.product_whey),
  ];

  List<_Product> get _filtered {
    final cat = _categories[_selected];
    if (cat == 'All') return _all;
    return _all.where((p) => p.tags.contains(cat)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // العنوان
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Protein offers',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // شريط التصنيفات (كابسولات بخط أخضر عند التحديد)
        SizedBox(
          height: 46,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final active = i == _selected;
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
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
                                  color: AppColors.greenAccent.withOpacity(.16),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _categories[i],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // خط أخضر سفلي يوضّح الاختيار
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      height: active ? 3 : 0,
                      width: 36,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: AppColors.greenAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // شبكة المنتجات المفلترة بحسب التصنيف المختار
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: .95,
            ),
            itemBuilder: (_, i) => _ProductCard(
              title: _filtered[i].title,
              price: _filtered[i].price,
              imageAsset: _filtered[i].imageAsset,
              // تلميح صغير عن التصنيفات (اختياري)
              subtitle: _filtered[i].tags.where((t) => t != 'All').take(2).join(' • '),
            ),
          ),
        ),
      ]),
    );
  }
}

/* ===================== Models & Widgets ===================== */

class _Product {
  final String title;
  final String price;
  final List<String> tags; // التصنيفات المرتبطة بالمنتج
  final String imageAsset;
  _Product(this.title, this.price, this.tags, this.imageAsset);
}

class _ProductCard extends StatelessWidget {
  final String title, price, imageAsset;
  final String? subtitle;
  const _ProductCard({
    required this.title,
    required this.price,
    required this.imageAsset,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const kCard = Color(0xFF223044);
    const kBorder = Color(0xFF2A2F38);

    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(child: Image.asset(imageAsset, fit: BoxFit.contain)),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 11.5,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            price,
            style: GoogleFonts.poppins(
              color: AppColors.greenAccent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

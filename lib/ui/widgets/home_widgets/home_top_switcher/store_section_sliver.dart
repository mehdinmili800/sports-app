import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';

class StoreSectionSliver extends StatefulWidget {
  const StoreSectionSliver({super.key});

  @override
  State<StoreSectionSliver> createState() => _StoreSectionSliverState();
}

class _StoreSectionSliverState extends State<StoreSectionSliver> {
  // الرياضات (مثل صفحة المدربين)
  final List<(String, IconData)> _sports = const [
    ('Football', Icons.sports_soccer),
    ('Basketball', Icons.sports_basketball),
    ('Tennis', Icons.sports_tennis),
    ('Swimming', Icons.pool),
    ('Running', Icons.directions_run),
    ('Boxing', Icons.sports_mma),
    ('Cycling', Icons.directions_bike),
    ('More', Icons.arrow_forward_rounded),
  ];

  // الافتراضي: Football
  int _sportIndex = 0;

  // التصنيفات الفرعية لكل رياضة
  final Map<String, List<String>> _subcatsBySport = const {
    'Football': [
      'All',
      'Boots',
      'Balls',
      'Jerseys',
      'Gloves',
      'Shin Pads',
      'Bags',
      'Accessories'
    ],
    'Basketball': [
      'All',
      'Shoes',
      'Balls',
      'Jerseys',
      'Arm Sleeves',
      'Bags',
      'Accessories'
    ],
    'Tennis': [
      'All',
      'Rackets',
      'Strings',
      'Balls',
      'Grips',
      'Bags',
      'Accessories'
    ],
    'Swimming': [
      'All',
      'Goggles',
      'Caps',
      'Suits',
      'Fins',
      'Bags',
      'Accessories'
    ],
    'Running': [
      'All',
      'Shoes',
      'Socks',
      'Hydration',
      'Belts',
      'Bags',
      'Accessories'
    ],
    'Boxing': [
      'All',
      'Gloves',
      'Pads',
      'Wraps',
      'Bags',
      'Headgear',
      'Accessories'
    ],
    'Cycling': [
      'All',
      'Helmets',
      'Gloves',
      'Jerseys',
      'Bottles',
      'Bags',
      'Accessories'
    ],
    'More': ['All', 'Accessories'],
  };

  int _subcatIndex = 0;

  // بيانات المنتجات (تجريبية): sport + subcategory tags
  late final List<_StoreItem> _all = [
    // Football
    _StoreItem('Nike Mercurial', 'AED 320', ['Football', 'Boots'],
        AppImages.nike),
    _StoreItem('Official Match Ball', 'AED 240', ['Football', 'Balls'],
        AppImages.nike),
    _StoreItem('Pro Shin Pads', 'AED 130', ['Football', 'Shin Pads'],
        AppImages.nike),
    _StoreItem('Club Jersey', 'AED 180', ['Football', 'Jerseys'],
        AppImages.nike),
    _StoreItem('Goalkeeper Gloves', 'AED 210', ['Football', 'Gloves'],
        AppImages.nike),
    _StoreItem('Training Bag', 'AED 160', ['Football', 'Bags'],
        AppImages.nike),
    // Basketball
    _StoreItem('Bounce Shoes', 'AED 310', ['Basketball', 'Shoes'],
        AppImages.nike),
    _StoreItem('Indoor Ball', 'AED 220', ['Basketball', 'Balls'],
        AppImages.nike),
    _StoreItem('Sleeve Pro', 'AED 85', ['Basketball', 'Arm Sleeves'],
        AppImages.nike),
    // Tennis
    _StoreItem(
        'Pro Racket', 'AED 450', ['Tennis', 'Rackets'], AppImages.nike),
    _StoreItem('Spin Strings', 'AED 70', ['Tennis', 'Strings'],
        AppImages.nike),
    _StoreItem('Tennis Balls 4', 'AED 45', ['Tennis', 'Balls'],
        AppImages.nike),
    _StoreItem(
        'Overgrip 3x', 'AED 35', ['Tennis', 'Grips'], AppImages.nike),
    _StoreItem(
        'Racket Bag', 'AED 190', ['Tennis', 'Bags'], AppImages.nike),
    // Running
    _StoreItem(
        'Road Shoes', 'AED 290', ['Running', 'Shoes'], AppImages.nike),
    _StoreItem('Hydration Belt', 'AED 110', ['Running', 'Hydration'],
        AppImages.nike),
    // Boxing
    _StoreItem('Boxing Gloves 12oz', 'AED 210', ['Boxing', 'Gloves'],
        AppImages.nike),
    _StoreItem(
        'Focus Pads', 'AED 160', ['Boxing', 'Pads'], AppImages.nike),
    _StoreItem(
        'Hand Wraps', 'AED 40', ['Boxing', 'Wraps'], AppImages.nike),
    // Cycling
    _StoreItem('Road Helmet', 'AED 260', ['Cycling', 'Helmets'],
        AppImages.nike),
    _StoreItem('Cycling Jersey', 'AED 175', ['Cycling', 'Jerseys'],
        AppImages.nike),
    _StoreItem('Bottle 750ml', 'AED 45', ['Cycling', 'Bottles'],
        AppImages.nike),
    // Swimming
    _StoreItem('Anti-fog Goggles', 'AED 95', ['Swimming', 'Goggles'],
        AppImages.nike),
    _StoreItem(
        'Swim Cap', 'AED 30', ['Swimming', 'Caps'], AppImages.nike),
    _StoreItem('Training Fins', 'AED 140', ['Swimming', 'Fins'],
        AppImages.nike),
  ];

  List<_StoreItem> get _filtered {
    final sport = _sports[_sportIndex].$1;
    final subcats = _subcatsBySport[sport] ?? const ['All'];
    final sub = subcats[_subcatIndex];

    final base = _all.where((p) => p.tags.contains(sport)).toList();
    if (sub == 'All') return base;
    return base.where((p) => p.tags.contains(sub)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sportName = _sports[_sportIndex].$1;
    final subcats = _subcatsBySport[sportName] ?? const ['All'];

    return SliverList(
      delegate: SliverChildListDelegate([
        // عنوان
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sports Store',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ===== Shop by sport (مع تنسيق أخضر للحالة النشطة) =====
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sports.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.10,
            ),
            itemBuilder: (_, i) {
              final selected = i == _sportIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _sportIndex = i;
                    _subcatIndex = 0;
                  });
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected
                              ? AppColors.greenAccent.withOpacity(.45)
                              : AppColors.border,
                          width: selected ? 1.3 : 1,
                        ),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: AppColors.greenAccent.withOpacity(.18),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_sports[i].$2, color: Colors.white, size: 22),
                          const SizedBox(height: 6),
                          Text(
                            _sports[i].$1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        height: selected ? 3.0 : 0.0,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.greenAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 14),

        // ===== Subcategories bar (كابسولات + خط أخضر) =====
        SizedBox(
          height: 46,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: subcats.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final active = i == _subcatIndex;
              return GestureDetector(
                onTap: () => setState(() => _subcatIndex = i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                        subcats[i],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

        // ===== شبكة المنتجات المفلترة =====
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
              childAspectRatio: .93,
            ),
            itemBuilder: (_, i) => _StoreProductCard(
              title: _filtered[i].title,
              price: _filtered[i].price,
              imageAsset: _filtered[i].imageAsset,
              subtitle: _filtered[i]
                  .tags
                  .where((t) => t != _sports[_sportIndex].$1)
                  .take(2)
                  .join(' • '),
            ),
          ),
        ),

        const SizedBox(height: 8),
      ]),
    );
  }
}

/* ===================== Helpers & Cards ===================== */

class _SportTileLite extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SportTileLite({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    const kCard = Color(0xFF223044);
    const kBorder = Color(0xFF2A2F38);
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StoreItem {
  final String title;
  final String price;
  final List<String> tags; // [sport, subcategory, ...]
  final String imageAsset;
  _StoreItem(this.title, this.price, this.tags, this.imageAsset);
}

class _StoreProductCard extends StatelessWidget {
  final String title, price, imageAsset;
  final String? subtitle;
  const _StoreProductCard({
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
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // صورة
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 56),
              child: Image.asset(imageAsset, fit: BoxFit.contain),
            ),
          ),

          // أسفل البطاقة
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2430),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2F38)),
              ),
              child: Row(
                children: [
                  // العنوان + التصنيف المختصر
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.white70, fontSize: 11.5),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                        color: AppColors.greenAccent,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),

          // مفضلة (اختياري)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0x1AFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: const Icon(Icons.favorite_border,
                  color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/data/models/sport.dart';
import 'package:hanae_app/ui/widgets/home_widgets/sport_tile.dart';

class FieldsSectionSliver extends StatefulWidget {
  final bool isNarrow;
  const FieldsSectionSliver({super.key, required this.isNarrow});

  @override
  State<FieldsSectionSliver> createState() => _FieldsSectionSliverState();
}

class _FieldsSectionSliverState extends State<FieldsSectionSliver> {
  // الافتراضي: Football
  int _selectedIndex = 0;

  // Grid رياضات (يبقى كما هو)
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

  // بيانات ملاعب للتجربة (استخدم صورك من AppImages)
  final List<_FieldData> _fields = [
    _FieldData('Football Field', AppImages.footballField, 'AED 200/hr', '1.5 km'),
    _FieldData('Tennis Court',   AppImages.tennisField,   'AED 100/hr', '3.2 km'),
    _FieldData('Boxing Arena',   AppImages.boxingField,   'AED 150/hr', '2.0 km'),
    _FieldData('Football Field', AppImages.footballField, 'AED 220/hr', '4.1 km'),
    _FieldData('Tennis Court',   AppImages.tennisField,   'AED 120/hr', '2.7 km'),
    _FieldData('Boxing Arena',   AppImages.boxingField,   'AED 160/hr', '3.9 km'),
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = widget.isNarrow;

    return SliverList(
      delegate: SliverChildListDelegate([
        // العنوان
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Choose your sport',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 10),

        // Grid مع اختيار + خط أخضر سفلي عند التحديد
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
              final selected = i == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // البلاطة الأصلية
                    SportTile(s: Sport(_sports[i].$2, _sports[i].$1)),

                    // خط أخضر سفلي عند التحديد
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

        // عنوان قسم الملاعب
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Nearby fields',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 10),

        // شبكة بطاقات ملاعب كبيرة (صورة بارزة)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _fields.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isNarrow ? 1 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: isNarrow ? 1.55 : 1.45,
            ),
            itemBuilder: (_, i) => _BigFieldCard(data: _fields[i]),
          ),
        ),

        const SizedBox(height: 12),
      ]),
    );
  }
}

/* ====================== Helpers ====================== */

class _FieldData {
  final String title;
  final String imageAsset;
  final String price;
  final String distance;
  const _FieldData(this.title, this.imageAsset, this.price, this.distance);
}

class _BigFieldCard extends StatelessWidget {
  final _FieldData data;
  const _BigFieldCard({required this.data});

  @override
  Widget build(BuildContext context) {
    const kBorder = Color(0xFF2A2F38);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          // صورة الملعب الكبيرة
          Positioned.fill(
            child: Image.asset(
              data.imageAsset,
              fit: BoxFit.cover,
            ),
          ),

          // تدرّج سفلي لقراءة النص
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xCC0B0F10),
                  ],
                  stops: [0.45, 1.0],
                ),
                border: Border.all(color: kBorder),
              ),
            ),
          ),

          // محتوى النص + السعر + زر Book (معالجة overflow)
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // النصوص (عنوان + تفاصيل)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),

                      LayoutBuilder(
                        builder: (context, c) {
                          final tight = c.maxWidth < 100;
                          return Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: data.distance,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: tight ? 11 : 12.5,
                                ),
                              ),
                              TextSpan(
                                text: '  •  ',
                                style: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: tight ? 11 : 12.5,
                                ),
                              ),
                              TextSpan(
                                text: data.price,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF22C55E),
                                  fontWeight: FontWeight.w700,
                                  fontSize: tight ? 12 : 13.5,
                                ),
                              ),
                            ]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // زر Book بعرض أدنى صغير حتى لا يزاحم النص
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 72),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(0, 0),
                    ),
                    child: const Text('Book'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

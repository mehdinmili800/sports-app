// trainers_section_sliver.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/data/models/sport.dart';
import 'package:hanae_app/ui/widgets/home_widgets/sport_tile.dart';
import 'package:hanae_app/ui/widgets/home_widgets/trainer_row.dart';

class TrainersSectionSliver extends StatefulWidget {
  final bool isNarrow;
  const TrainersSectionSliver({super.key, required this.isNarrow});

  @override
  State<TrainersSectionSliver> createState() => _TrainersSectionSliverState();
}

class _TrainersSectionSliverState extends State<TrainersSectionSliver> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Choose your sport',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sports.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.10),
            itemBuilder: (_, i) {
              final selected = i == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SportTile(s: Sport(_sports[i].$2, _sports[i].$1)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        height: selected ? 3.0 : 0.0,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.greenAccent, borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Trainers',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 8),

        // ✅ استخدم صور المدرّبين
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TrainerRow(
                isNarrow: widget.isNarrow,
                offerTitle: 'Coach Store',
                offerIconSvg: AppImages.market,
                trainerImage: const AssetImage(AppImages.trainer1),
              ),
              const SizedBox(height: 12),
              TrainerRow(
                isNarrow: widget.isNarrow,
                offerTitle: 'Coach Store',
                offerIconSvg: AppImages.market,
                trainerImage: const AssetImage(AppImages.trainer2),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ]),
    );
  }
}

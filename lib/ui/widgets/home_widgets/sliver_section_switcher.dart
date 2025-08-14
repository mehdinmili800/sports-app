import 'package:flutter/widgets.dart';
import 'package:hanae_app/ui/widgets/home_widgets/home_top_switcher/fields_section_sliver.dart';
import 'package:hanae_app/ui/widgets/home_widgets/home_top_switcher/proteins_section_sliver.dart';
import 'package:hanae_app/ui/widgets/home_widgets/home_top_switcher/store_section_sliver.dart';
import 'package:hanae_app/ui/widgets/home_widgets/home_top_switcher/trainers_section_sliver.dart';


class SliverSectionSwitcher extends StatelessWidget {
  final int tab;       // 0 Trainers, 1 Fields, 2 Proteins, 3 Store
  final bool isNarrow;
  const SliverSectionSwitcher({super.key, required this.tab, required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case 0: return TrainersSectionSliver(isNarrow: isNarrow);
      case 1: return  FieldsSectionSliver(isNarrow: isNarrow);
      case 2: return const ProteinsSectionSliver();
      case 3: return const StoreSectionSliver();
      default: return TrainersSectionSliver(isNarrow: isNarrow);
    }
  }
}

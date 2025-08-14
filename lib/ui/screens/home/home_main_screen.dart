import 'package:flutter/material.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/ui/widgets/home_widgets/hero_banner_carousel.dart';
import 'package:hanae_app/ui/widgets/home_widgets/search_bar_widget.dart';
import 'package:hanae_app/ui/widgets/home_widgets/sliver_section_switcher.dart';
import 'package:hanae_app/ui/widgets/home_widgets/top_caps.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);
  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int topSelected = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 370;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // TopCaps (ثابت)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              sliver: SliverToBoxAdapter(
                child: TopCaps(
                  selected: topSelected,
                  onTap: (i) => setState(() => topSelected = i),
                ),
              ),
            ),

            // Search (ثابت)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(child: SearchBarWidget()),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Banner (ثابت)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: HeroBannerCarousel(
                  height: 96,
                  images: const [
                    AssetImage(AppImages.ads1),
                    AssetImage(AppImages.ads2), // اضف صورك الأخرى
                    AssetImage(AppImages.ads3),
                  ],
                  onBuy: (i) {
                    // TODO: تعامل مع الشراء لكل إعلان حسب index
                  },
                  // autoPlayInterval: const Duration(seconds: 5), // اختياري
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // المحتوى المتغير حسب التبويب العلوي
            SliverSectionSwitcher(tab: topSelected, isNarrow: isNarrow),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/data/models/product.dart';
import 'package:hanae_app/ui/widgets/market_widgets/product_card.dart';
import 'package:hanae_app/ui/widgets/market_widgets/promo_banner.dart';
import 'package:hanae_app/ui/widgets/market_widgets/search_bar.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final TextEditingController _search = TextEditingController();

  final List<String> _categories = [
    "Vitamins", "Proteins", "Fat Burners", "Pre-Workout"
  ];
  int _selectedCat = 0;

  final List<Product> _all = [
    Product("Magnesium Tabs", 24.99, imageAsset: AppImages.product_whey),
    Product("Whey Protein", 39.99, imageAsset: AppImages.product_whey),
    Product("Vitamin D", 14.99, imageAsset: AppImages.product_whey),
    Product("Fish Oil", 19.99, imageAsset: AppImages.product_whey),
    Product("Zinc Tabs", 21.99, placeholder: "ZINC"),
  ];

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final q = _search.text.trim().toLowerCase();
    final items = q.isEmpty
        ? _all
        : _all.where((p) => p.name.toLowerCase().contains(q)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: r.hp(0.03)),
          children: [
            // ---------- Search ----------
            Padding(
              padding: EdgeInsets.fromLTRB(r.wp(0.045), r.hp(0.028), r.wp(0.045), 0),
              child: SearchWidget(
                controller: _search,
                onChanged: (_) => setState(() {}),
              ),
            ),
            // زيادة المسافة بعد البحث
            SizedBox(height: r.hp(0.018)),
            // ---------- Categories Chips ----------
            SizedBox(
              height: r.hp(0.061),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: r.wp(0.035)),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final selected = _selectedCat == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCat = i),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: r.wp(0.048), vertical: r.hp(0.011)),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.greenAccent.withOpacity(0.12)
                            : AppColors.inputDark,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected
                              ? AppColors.greenAccent
                              : Colors.white12,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _categories[i],
                          style: GoogleFonts.poppins(
                            color: selected
                                ? AppColors.greenAccent
                                : Colors.white.withOpacity(0.92),
                            fontWeight: FontWeight.w600,
                            fontSize: r.sp(0.033),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: r.wp(0.026)),
                itemCount: _categories.length,
              ),
            ),
            // زيادة المسافة بعد الكاتيجوري
            SizedBox(height: r.hp(0.022)),
            // ---------- Promo Banner ----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(0.035)),
              child: PromoBanner(r: r),
            ),
            // زيادة المسافة بعد البانر
            SizedBox(height: r.hp(0.022)),
            // ---------- Products Grid ----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(0.025)),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: r.hp(0.024),
                  crossAxisSpacing: r.wp(0.036),
                  childAspectRatio: 0.94,
                ),
                itemBuilder: (_, i) => ProductCard(
                  r: r,
                  product: items[i],
                  onAdd: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.inputDark,
                        content: Text(
                          'Added: ${items[i].name}',
                          style: GoogleFonts.poppins(color: AppColors.greenAccent),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

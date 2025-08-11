import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Responsive r;
  final Product product;
  final VoidCallback onAdd;
  const ProductCard({
    required this.r,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181C21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greenAccent.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenAccent.withOpacity(0.08),
            blurRadius: 16, offset: Offset(0, 8),
          )
        ],
      ),
      padding: EdgeInsets.all(r.wp(0.022)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.imageAsset != null && product.imageAsset!.isNotEmpty)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageAsset!,
                  width: r.wp(0.15),
                  height: r.wp(0.15),
                  fit: BoxFit.contain,
                ),
              ),
            )
          else
            Container(
              width: r.wp(0.15),
              height: r.wp(0.15),
              decoration: BoxDecoration(
                color: AppColors.inputDark.withOpacity(0.87),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greenAccent.withOpacity(0.09)),
              ),
              child: Center(
                child: Text(
                  product.placeholder ?? 'No Image',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: r.sp(0.031),
                  ),
                ),
              ),
            ),
          SizedBox(height: r.hp(0.011)),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: r.sp(0.028),
            ),
          ),
          SizedBox(height: r.hp(0.002)),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.94),
                  fontWeight: FontWeight.w700,
                  fontSize: r.sp(0.032),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(13),
                child: Ink(
                  width: r.wp(0.075),
                  height: r.wp(0.075),
                  decoration: BoxDecoration(
                    color: AppColors.greenAccent.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: AppColors.greenAccent, width: 1),
                  ),
                  child: const Icon(Icons.add, color: AppColors.greenAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

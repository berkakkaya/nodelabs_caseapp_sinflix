import "package:flutter/material.dart";
import "package:flutter_inner_shadow/flutter_inner_shadow.dart";
import "package:google_fonts/google_fonts.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

class TokenPackage extends StatelessWidget {
  final int discountPercent;
  final int originalValue;
  final int increasedValue;
  final String price;
  final bool isBestDeal;

  const TokenPackage({
    super.key,
    required this.discountPercent,
    required this.originalValue,
    required this.increasedValue,
    required this.price,
    this.isBestDeal = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeBodyMedium = Theme.of(context).textTheme.bodyMedium;
    final montserratFont = GoogleFonts.montserrat();

    return SizedBox(
      height: 231.78,
      child: Stack(
        children: [
          Positioned.fill(
            top: 14,
            child: InnerShadow(
              shadows: [
                Shadow(
                  color: kColorWhite.withValues(alpha: 0.3),
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  gradient: isBestDeal
                      ? kColorGradientBestOffer
                      : kColorGradientOffer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    // Original value with strike through
                    Text(
                      "$originalValue",
                      style: themeBodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        decoration: TextDecoration.lineThrough,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Discounted value
                    Text(
                      "$increasedValue",
                      style: montserratFont.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Jeton",
                      style: themeBodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    // Price
                    Text(
                      price,
                      style: montserratFont.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Başına haftalık",
                      style: themeBodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: InnerShadow(
                shadows: [
                  Shadow(
                    color: kColorWhite,
                    offset: const Offset(0, 0),
                    blurRadius: 8.33,
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.5,
                    vertical: 3.5,
                  ),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color: isBestDeal ? kColorBlue : kColorDarkRed,
                  ),
                  child: Text(
                    "+$discountPercent%",
                    style: themeBodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

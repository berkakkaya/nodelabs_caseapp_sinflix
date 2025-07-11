import "dart:ui";

import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/flexible_row_spacer.dart";

class LimitedOfferBg extends StatelessWidget {
  final Widget child;

  const LimitedOfferBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double cardBorderRadius = 32;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(cardBorderRadius),
        topRight: Radius.circular(cardBorderRadius),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: ColoredBox(color: kColorBlack)),
          Positioned(
            top: -83.74,
            left: 0,
            right: 0,
            child: Center(
              child: FlexibleRowSpacer(
                child: SizedBox.square(
                  dimension: 217.39,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kColorBrand,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -83.74,
            left: 0,
            right: 0,
            child: Center(
              child: FlexibleRowSpacer(
                child: SizedBox.square(
                  dimension: 217.39,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kColorBrand,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 216.25, sigmaY: 216.25),
              child: ColoredBox(color: Colors.transparent),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

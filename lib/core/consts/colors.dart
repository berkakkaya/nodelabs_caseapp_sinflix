import "package:flutter/material.dart";

const kColorBrand = Color(0xFFE50914);

const kColorBlack = Color(0xFF080808);
final kColorBlackA75 = kColorBlack.withValues(alpha: 0.75);
final kColorBlackA20 = kColorBlack.withValues(alpha: 0.20);

/// A gradient that goes from black to transparent, used for the bottom
/// of movie views.
final kColorBlackGradientTTB = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [kColorBlack, Colors.transparent],
);

const kColorWhite = Color(0xFFFFFFFF);
final kColorWhiteA75 = kColorWhite.withValues(alpha: 0.75);
final kColorWhiteA50 = kColorWhite.withValues(alpha: 0.50);
final kColorWhiteA20 = kColorWhite.withValues(alpha: 0.20);
final kColorWhiteA10 = kColorWhite.withValues(alpha: 0.10);

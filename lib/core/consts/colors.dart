import "package:flutter/material.dart";

const kColorBrand = Color(0xFFE50914);
const kColorDarkRed = Color(0xFF6F060B);

const kColorBlack = Color(0xFF080808);
final kColorBlackA75 = kColorBlack.withValues(alpha: 0.75);
final kColorBlackA20 = kColorBlack.withValues(alpha: 0.20);

const kColorWhite = Color(0xFFFFFFFF);
final kColorWhiteA75 = kColorWhite.withValues(alpha: 0.75);
final kColorWhiteA50 = kColorWhite.withValues(alpha: 0.50);
final kColorWhiteA20 = kColorWhite.withValues(alpha: 0.20);
final kColorWhiteA10 = kColorWhite.withValues(alpha: 0.10);

/// Color used for the best offer cards.
final kColorBlue = Color(0xFF5949E6);

/// A gradient that goes from black to transparent, used for the bottom
/// of movie views.
final kColorBlackGradientTTB = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [kColorBlack, Colors.transparent],
);

/// A gradient that used for the offer cards.
final kColorGradientOffer = RadialGradient(
  center: Alignment(-0.65, -0.65),
  radius: 1.70,
  colors: [const Color(0xFF6E050A), kColorBrand],
);

/// A gradient that used for the best offer cards.
final kColorGradientBestOffer = RadialGradient(
  center: Alignment(-0.65, -0.65),
  radius: 1.70,
  colors: [const Color(0xFF5849E6), kColorBrand],
);

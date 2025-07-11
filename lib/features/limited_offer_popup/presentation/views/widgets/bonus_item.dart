import "package:flutter/material.dart";
import "package:flutter_inner_shadow/flutter_inner_shadow.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

class BonusItem extends StatelessWidget {
  final ImageProvider iconImgProvider;
  final IconData icon;
  final String title;

  const BonusItem({
    super.key,
    required this.iconImgProvider,
    this.icon = Icons.diamond,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InnerShadow(
          shadows: [
            Shadow(
              color: kColorWhite,
              offset: const Offset(0, 0),
              blurRadius: 8.33,
            ),
          ],
          child: Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: kColorDarkRed,
              shape: BoxShape.circle,
            ),
            child: Image(image: iconImgProvider, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

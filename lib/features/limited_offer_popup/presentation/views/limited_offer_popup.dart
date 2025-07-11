import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/img_assets.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/flexible_row_spacer.dart";
import "package:nodelabs_caseapp_sinflix/features/limited_offer_popup/presentation/views/widgets/index.dart";

class LimitedOfferPopup extends StatelessWidget {
  const LimitedOfferPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        image: DecorationImage(
          image: AssetImage(kImgLimitedTimeOfferBg),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17.11, vertical: 17.43),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 7.53),
          Text(
            "Sınırlı Teklif",
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.37),
          // Description
          FlexibleRowSpacer(
            childFlex: 9,
            child: Text(
              "Jeton paketi'ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: kColorWhite),
            ),
          ),
          const SizedBox(height: 12.79),
          Container(
            padding: const EdgeInsets.only(
              top: 20.26,
              left: 20.25,
              right: 20.25,
              bottom: 14.26,
            ),
            decoration: BoxDecoration(
              color: kColorWhiteA10,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: kColorWhiteA10,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Alacağınız Bonuslar",
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BonusItem(
                        iconImgProvider: const AssetImage(kImgDiamond),
                        title: "Premium Hesap",
                      ),
                    ),
                    Expanded(
                      child: BonusItem(
                        iconImgProvider: const AssetImage(kImgCoupleHearts),
                        icon: Icons.favorite,
                        title: "Daha Fazla Eşleşme",
                      ),
                    ),
                    Expanded(
                      child: BonusItem(
                        iconImgProvider: const AssetImage(kImgArrowUp),
                        icon: Icons.arrow_upward,
                        title: "Öne Çıkarma",
                      ),
                    ),
                    Expanded(
                      child: BonusItem(
                        iconImgProvider: const AssetImage(kImgHeart),
                        icon: Icons.favorite_border,
                        title: "Daha Fazla Beğeni",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 21.97),
          Text(
            "Kilidi açmak için bir jeton paketi seçin",
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Token packages
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TokenPackage(
                  discountPercent: 10,
                  originalValue: 200,
                  increasedValue: 330,
                  price: "₺99,99",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TokenPackage(
                  discountPercent: 70,
                  originalValue: 2000,
                  increasedValue: 3375,
                  price: "₺799,99",
                  isBestDeal: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TokenPackage(
                  discountPercent: 35,
                  originalValue: 1000,
                  increasedValue: 1350,
                  price: "₺399,99",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Tüm Jetonları Gör"),
          ),
        ],
      ),
    );
  }
}

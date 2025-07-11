
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/custom_appbar.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/widgets/liked_movie_widget.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/widgets/profile_details_widget.dart";
import "package:nodelabs_caseapp_sinflix/features/limited_offer_popup/presentation/views/limited_offer_popup.dart";

class HomeScreenProfileTab extends StatelessWidget {
  const HomeScreenProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement pull-to-refresh functionality
          await Future.delayed(Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 38.04, right: 26.14, left: 24.95),
              sliver: SliverToBoxAdapter(
                child: CustomAppbar(
                  title: Text("Profil Detayı"),
                  suffix: FilledButton.icon(
                    onPressed: () => openLimitedOfferBottomSheet(context),
                    label: Text(
                      "Sınırlı Teklif",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    icon: Icon(CustomIcons.diamond),
                    style: theme.filledButtonTheme.style?.copyWith(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 9.39, vertical: 7.68),
                      ),
                      shape: WidgetStatePropertyAll(StadiumBorder()),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 36.64, left: 35.12, right: 26.15),
              sliver: SliverToBoxAdapter(
                child: ProfileDetailsWidget(
                  nameSurname: "Berk Akkaya",
                  userId: "aaa",
                  onProfileImgChangeClicked: () {},
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 28.97, left: 40.04, right: 40.04),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Beğendiğim Filmler",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 40.04, vertical: 23.86),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return LikedMovieWidget(
                      posterImgProvider: CachedNetworkImageProvider(
                        "https://images.unsplash.com/photo-1613928521908-24ccf17a1707?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      ),
                      title: "Deneme $index",
                      description: "Açıklama $index",
                    );
                  },
                  childCount: 10, // Example count
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.21,
                  crossAxisSpacing: 15.66,
                  childAspectRatio: 153.13 / 262.82,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openLimitedOfferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LimitedOfferPopup(),
    );
  }
}

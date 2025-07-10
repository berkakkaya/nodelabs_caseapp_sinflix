import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/views/widgets/movie_view.dart";

class HomeDiscoverTab extends StatelessWidget {
  const HomeDiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SafeArea(
            child: MovieView(
              imgProvider: NetworkImage(
                "https://m.media-amazon.com/images/M/MV5BZWQ4MzVjMjctYzNiNy00MGQ4LWFjZWEtZjQzMmQ3NTY4NGMxXkEyXkFqcGc@._V1_FMjpg_UY4642_.jpg",
              ),
              title: "Test Movie",
              description: "Test Description",
            ),
          );
        },
      ),
    );
  }
}

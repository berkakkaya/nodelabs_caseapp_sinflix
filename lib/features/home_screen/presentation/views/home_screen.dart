import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/bloc/events.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/bloc/home_screen_viewmodel.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/views/home_discover_tab.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/profile_tab.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/views/widgets/custom_bottom_navbar.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/views/widgets/tab_chip.dart";
import "../bloc/home_tab_state.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenViewModel(),
      child: BlocBuilder<HomeScreenViewModel, TabState>(
        builder: (context, state) {
          final bloc = context.read<HomeScreenViewModel>();

          final screens = [
            const HomeDiscoverTab(),
            const HomeScreenProfileTab(),
          ];
          return Scaffold(
            body: screens[state.selectedIndex],
            bottomNavigationBar: CustomBottomNavbar(
              items: [
                TabChip(
                  label: "Anasayfa",
                  icon: Icon(CustomIcons.homeOutlined),
                  onTap: () => bloc.add(HomeDiscoverTabTapped()),
                ),
                TabChip(
                  label: "Profil",
                  icon: Icon(CustomIcons.person),
                  onTap: () => bloc.add(ProfileTabTapped()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

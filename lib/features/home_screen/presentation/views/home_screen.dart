import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/bloc/events.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/bloc/home_screen_viewmodel.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/views/home_discover_tab.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/profile_tab.dart";
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
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => bloc.add(
                index == 0 ? HomeDiscoverTabTapped() : ProfileTabTapped(),
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Anasayfa",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profil",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

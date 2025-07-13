import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/datasources/movie_datasource.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/repositories/movie_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/get_favorite_movies_usecase.dart"
    show GetFavoriteMoviesUsecase;
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/get_movies_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/toggle_favorite_usecase.dart"
    show ToggleFavoriteUsecase;
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_event.dart";
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenViewModel>(
          create: (context) => HomeScreenViewModel(),
        ),
        BlocProvider<MovieBloc>(create: (context) => _createMovieBloc(context)),
      ],
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

  MovieBloc _createMovieBloc(BuildContext context) {
    final apiService = GetIt.I.get<RestApiService>();

    final movieDatasource = MovieDatasourceImpl(apiService: apiService);
    final repository = DiscoverRepositoryImpl(dataSource: movieDatasource);

    return MovieBloc(
      getMoviesUsecase: GetMoviesUsecase(repository),
      getFavoriteMoviesUsecase: GetFavoriteMoviesUsecase(repository),
      toggleFavoriteUsecase: ToggleFavoriteUsecase(repository),
    )..add(FetchMoviesEvent());
  }
}

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/custom_appbar.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/views/add_profile_photo_screen.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_bloc.dart"
    show AuthBloc;
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_state.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_state.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/data/datasources/profile_tab_datasource.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/data/repositories/movie_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/usecases/get_favorite_movies_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/bloc/favourite_movies_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/bloc/favourite_movies_event.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/bloc/favourite_movies_state.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/widgets/liked_movie_widget.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/views/widgets/profile_details_widget.dart";
import "package:nodelabs_caseapp_sinflix/features/limited_offer_popup/presentation/views/limited_offer_popup.dart";

class HomeScreenProfileTab extends StatelessWidget {
  const HomeScreenProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authBloc = context.read<AuthBloc>();

    return BlocProvider(
      create: (context) => createFavouriteMoviesBloc(context),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            authBloc.add(UserDataReloadReqEvent());
            await Future.delayed(const Duration(seconds: 1));
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
                          EdgeInsets.symmetric(
                            horizontal: 9.39,
                            vertical: 7.68,
                          ),
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
                  child: BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (context, state) => state is AuthenticatedState,
                    builder: (context, state) {
                      if (state is! AuthenticatedState) {
                        return Center(
                          child: Text("Kullanıcı bilgisi alınıyor..."),
                        );
                      }

                      final profileImgUrl = state.user.photoUrl;

                      return ProfileDetailsWidget(
                        nameSurname: state.user.nameSurname,
                        userId: state.user.userId,
                        profileImgProvider: profileImgUrl != null
                            ? CachedNetworkImageProvider(profileImgUrl)
                            : null,
                        onProfileImgChangeClicked: () =>
                            goToProfileImgChangeScreen(context),
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8, left: 26.15, right: 26.15),
                sliver: SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => authBloc.add(SignOutEvent()),
                      child: Text("Oturumu Kapat"),
                    ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 40.04,
                  vertical: 23.86,
                ),
                sliver: BlocListener<MovieBloc, MovieState>(
                  listenWhen: (previous, current) =>
                      current is MovieLikeToggledState,
                  listener: _movieStateListener,
                  child: BlocBuilder<FavouriteMoviesBloc, FavouriteMoviesState>(
                    builder: (context, state) {
                      if (state is! FavouriteMoviesLoadedState) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final movies = state.movies;

                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final movie = movies[index];

                          return LikedMovieWidget(
                            posterImgProvider: CachedNetworkImageProvider(
                              movie.posterUrl,
                            ),
                            title: movie.title,
                            description: movie.description,
                          );
                        }, childCount: movies.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.21,
                          crossAxisSpacing: 15.66,
                          childAspectRatio: 153.13 / 262.82,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _movieStateListener(BuildContext context, MovieState state) {
    if (state is MovieLikeToggledState) {
      final bloc = context.read<FavouriteMoviesBloc>();
      bloc.add(FetchFavouriteMoviesEvent());
    }
  }

  FavouriteMoviesBloc createFavouriteMoviesBloc(BuildContext context) {
    final authService = GetIt.I.get<RestApiService>();

    return FavouriteMoviesBloc(
      GetFavoriteMoviesUsecase(
        ProfileTabRepositoryImpl(
          dataSource: ProfileTabDatasourceImpl(apiService: authService),
        ),
      ),
    )..add(FetchFavouriteMoviesEvent());
  }

  void openLimitedOfferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LimitedOfferPopup(),
    );
  }

  void goToProfileImgChangeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddProfilePhotoScreen()),
    );
  }
}

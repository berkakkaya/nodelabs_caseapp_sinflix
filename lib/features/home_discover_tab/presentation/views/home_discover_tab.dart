import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_event.dart"
    show MovieDiscoverScrollEvent, MovieLikeToggleEvent, FetchMoviesEvent;
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_state.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/views/widgets/movie_view.dart";

class HomeDiscoverTab extends StatelessWidget {
  const HomeDiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();

    return BlocBuilder<MovieBloc, MovieState>(
      bloc: movieBloc,
      builder: (context, state) {
        if (state is MovieInitialState) {
          // Trigger initial fetch if we're in initial state
          movieBloc.add(FetchMoviesEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("HATA: ${state.message}"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => movieBloc.add(FetchMoviesEvent()),
                  child: const Text("Tekrar Dene"),
                ),
              ],
            ),
          );
        } else if (state is MoviesLoadedState) {
          return PageView.builder(
            key: PageStorageKey("home_discover_tab_page_view"),
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              movieBloc.add(MovieDiscoverScrollEvent(index: index));
            },
            itemCount: state.movies.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                // Show loading indicator at the bottom when loading more
                return const Center(child: CircularProgressIndicator());
              }

              final movie = state.movies[index];

              return SafeArea(
                child: MovieView(
                  key: ValueKey("movie_${movie.movieId}"),
                  imgProvider: CachedNetworkImageProvider(movie.posterUrl),
                  title: movie.title,
                  description: movie.description,
                  isLiked: movie.isFavorite,
                  onLikeToggle: () {
                    movieBloc.add(MovieLikeToggleEvent(movie.movieId));
                  },
                ),
              );
            },
          );
        }

        return const Center(child: Text("Bilinmeyen durum"));
      },
    );
  }
}

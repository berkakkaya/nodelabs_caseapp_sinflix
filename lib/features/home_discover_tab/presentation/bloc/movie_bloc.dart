import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/get_favorite_movies_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/get_movies_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/usecases/toggle_favorite_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_event.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/presentation/bloc/movie_state.dart";

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUsecase getMoviesUsecase;
  final GetFavoriteMoviesUsecase getFavoriteMoviesUsecase;
  final ToggleFavoriteUsecase toggleFavoriteUsecase;

  // Constants for pagination control
  static const int _initialPage = 1;
  static const int _loadMoreThreshold =
      5; // Load more when user reaches this close to the end

  MovieBloc({
    required this.getMoviesUsecase,
    required this.getFavoriteMoviesUsecase,
    required this.toggleFavoriteUsecase,
  }) : super(MovieInitialState()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
    on<RefreshMoviesEvent>(_onRefreshMovies);
    on<MovieDiscoverScrollEvent>(_onMovieDiscoverScroll);
    on<MovieLikeToggleEvent>(_onMovieLikeToggle);
  }

  /// Handles the initial fetch of movies
  Future<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());

    try {
      final pagination = await getMoviesUsecase(pagination: _initialPage);

      emit(
        MoviesLoadedState(
          movies: pagination.movies,
          currentPage: pagination.currentPage,
          totalPages: pagination.totalPages,
          hasReachedEnd: pagination.currentPage >= pagination.totalPages,
        ),
      );
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }

  /// Handles loading more movies when user scrolls to the end
  Future<void> _onLoadMoreMovies(
    LoadMoreMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;

    if (currentState is MoviesLoadedState) {
      // Don't load more if we're already loading
      if (currentState.isLoadingMore) {
        return;
      }

      // Mark as loading more
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        // Calculate next page - if we've reached the end, start over from page 1
        final nextPage = currentState.currentPage >= currentState.totalPages
            ? _initialPage // Cycle back to first page
            : currentState.currentPage + 1;

        final pagination = await getMoviesUsecase(pagination: nextPage);

        // Create the updated movie list
        List<Movie> updatedMovies;

        // If we're starting over from page 1, append the new movies to the existing list
        // to maintain continuous scrolling
        if (nextPage == _initialPage) {
          updatedMovies = [...currentState.movies, ...pagination.movies];
        } else {
          // Normal case, just append the new page
          updatedMovies = [...currentState.movies, ...pagination.movies];
        }

        emit(
          MoviesLoadedState(
            movies: updatedMovies,
            currentPage: pagination.currentPage,
            totalPages: pagination.totalPages,
            // Never mark as reached end to allow infinite scrolling
            hasReachedEnd: false,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        // Restore previous state but mark as not loading
        emit(currentState.copyWith(isLoadingMore: false));
        emit(MovieErrorState(message: e.toString()));
      }
    }
  }

  /// Handles refreshing the movie list
  Future<void> _onRefreshMovies(
    RefreshMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());

    try {
      final pagination = await getMoviesUsecase(pagination: _initialPage);

      emit(
        MoviesLoadedState(
          movies: pagination.movies,
          currentPage: pagination.currentPage,
          totalPages: pagination.totalPages,
          hasReachedEnd: pagination.currentPage >= pagination.totalPages,
        ),
      );
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }

  /// Handles user scrolling to trigger pagination
  void _onMovieDiscoverScroll(
    MovieDiscoverScrollEvent event,
    Emitter<MovieState> emit,
  ) {
    final currentState = state;

    if (currentState is MoviesLoadedState) {
      // Check if we need to load more movies
      // We load more when user is approaching the end of the list
      if (!currentState.isLoadingMore &&
          event.index >= currentState.movies.length - _loadMoreThreshold) {
        add(LoadMoreMoviesEvent());
      }
    }
  }

  /// Handles toggling like/favorite status of a movie
  Future<void> _onMovieLikeToggle(
    MovieLikeToggleEvent event,
    Emitter<MovieState> emit,
  ) async {
    try {
      final isFavorited = await toggleFavoriteUsecase(event.movieId);

      // Emit toggle state
      emit(
        MovieLikeToggledState(movieId: event.movieId, isFavorited: isFavorited),
      );

      // Update movie list if needed
      if (state is MoviesLoadedState) {
        final currentState = state as MoviesLoadedState;

        // Update the favorite status in the current list
        final updatedMovies = currentState.movies.map((movie) {
          if (movie.movieId == event.movieId) {
            // Create a new movie with updated favorite status
            return Movie(
              movieId: movie.movieId,
              posterUrl: movie.posterUrl,
              title: movie.title,
              description: movie.description,
              isFavorite: isFavorited,
            );
          }
          return movie;
        }).toList();

        emit(currentState.copyWith(movies: updatedMovies));
      }
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }
}

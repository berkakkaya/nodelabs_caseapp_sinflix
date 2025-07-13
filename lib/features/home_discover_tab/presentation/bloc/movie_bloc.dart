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
  static const int _loadMoreThreshold = 5;

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
      if (currentState.isLoadingMore) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.currentPage >= currentState.totalPages
            ? _initialPage
            : currentState.currentPage + 1;

        final pagination = await getMoviesUsecase(pagination: nextPage);
        final updatedMovies = [...currentState.movies, ...pagination.movies];

        emit(
          MoviesLoadedState(
            movies: updatedMovies,
            currentPage: pagination.currentPage,
            totalPages: pagination.totalPages,
            hasReachedEnd: false,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
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
      final currentState = state;
      if (currentState is! MoviesLoadedState) {
        return;
      }

      // Find the movie
      final movie = currentState.movies.firstWhere(
        (m) => m.movieId == event.movieId,
        orElse: () => throw Exception("Movie not found: ${event.movieId}"),
      );

      // Perform optimistic update
      final tempIsFavorited = !movie.isFavorite;
      final immediateUpdatedMovies = currentState.movies.map((m) {
        if (m.movieId == event.movieId) {
          return Movie(
            movieId: m.movieId,
            posterUrl: m.posterUrl,
            title: m.title,
            description: m.description,
            isFavorite: tempIsFavorited,
          );
        }
        return m;
      }).toList();

      // Emit optimistic update immediately
      emit(
        MoviesLoadedState(
          movies: immediateUpdatedMovies,
          currentPage: currentState.currentPage,
          totalPages: currentState.totalPages,
          hasReachedEnd: currentState.hasReachedEnd,
          isLoadingMore: currentState.isLoadingMore,
        ),
      );

      // Make the actual API call
      final actualIsFavorited = await toggleFavoriteUsecase(event.movieId);

      // If API result differs from optimistic update, correct the state
      if (tempIsFavorited != actualIsFavorited) {
        final actualUpdatedMovies = immediateUpdatedMovies.map((m) {
          if (m.movieId == event.movieId) {
            return Movie(
              movieId: m.movieId,
              posterUrl: m.posterUrl,
              title: m.title,
              description: m.description,
              isFavorite: actualIsFavorited,
            );
          }
          return m;
        }).toList();

        emit(
          MoviesLoadedState(
            movies: actualUpdatedMovies,
            currentPage: currentState.currentPage,
            totalPages: currentState.totalPages,
            hasReachedEnd: currentState.hasReachedEnd,
            isLoadingMore: currentState.isLoadingMore,
          ),
        );
      }
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }
}

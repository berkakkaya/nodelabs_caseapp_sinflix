import "package:equatable/equatable.dart";

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch initial movies
class FetchMoviesEvent extends MovieEvent {}

/// Event to load more movies when user scrolls to the end
class LoadMoreMoviesEvent extends MovieEvent {}

/// Event to refresh the movie list
class RefreshMoviesEvent extends MovieEvent {}

/// Event triggered when user scrolls to a specific index
class MovieDiscoverScrollEvent extends MovieEvent {
  final int index;

  const MovieDiscoverScrollEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

/// Event to toggle like/favorite status of a movie
class MovieLikeToggleEvent extends MovieEvent {
  final String movieId;

  const MovieLikeToggleEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

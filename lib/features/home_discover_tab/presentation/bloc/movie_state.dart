import "package:equatable/equatable.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieErrorState extends MovieState {
  final String message;

  const MovieErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MoviesLoadedState extends MovieState {
  final List<Movie> movies;
  final int currentPage;
  final int totalPages;
  final bool hasReachedEnd;
  final bool isLoadingMore;

  const MoviesLoadedState({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    this.hasReachedEnd = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [
    movies,
    currentPage,
    totalPages,
    hasReachedEnd,
    isLoadingMore,
  ];

  MoviesLoadedState copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? totalPages,
    bool? hasReachedEnd,
    bool? isLoadingMore,
  }) {
    return MoviesLoadedState(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class MovieLikeToggledState extends MoviesLoadedState {
  final String favoriteMovieId;
  final bool isFavorited;

  MovieLikeToggledState({
    required this.favoriteMovieId,
    required this.isFavorited,
    List<Movie>? movies,
    int? currentPage,
    int? totalPages,
    super.hasReachedEnd,
    super.isLoadingMore,
  }) : super(
         movies: movies ?? [],
         currentPage: currentPage ?? 0,
         totalPages: totalPages ?? 0,
       );

  @override
  List<Object?> get props => [
    favoriteMovieId,
    isFavorited,
    movies,
    currentPage,
    totalPages,
    hasReachedEnd,
    isLoadingMore,
  ];
}

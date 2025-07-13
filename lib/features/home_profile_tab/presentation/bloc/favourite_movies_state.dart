import "package:equatable/equatable.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart";

sealed class FavouriteMoviesState extends Equatable {
  const FavouriteMoviesState();

  @override
  List<Object?> get props => [];
}

class InitFavouriteMoviesState extends FavouriteMoviesState {}

class FavouriteMoviesLoadingState extends FavouriteMoviesState {}

class FavouriteMoviesLoadedState extends FavouriteMoviesState {
  final List<Movie> movies;

  const FavouriteMoviesLoadedState({required this.movies});

  @override
  List<Object?> get props => [movies];
}

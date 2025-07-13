import "package:equatable/equatable.dart";

sealed class FavouriteMoviesEvent extends Equatable {
  const FavouriteMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavouriteMoviesEvent extends FavouriteMoviesEvent {
  const FetchFavouriteMoviesEvent();

  @override
  List<Object?> get props => [];
}

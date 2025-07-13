import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/usecases/get_favorite_movies_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/bloc/favourite_movies_event.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/presentation/bloc/favourite_movies_state.dart";

class FavouriteMoviesBloc
    extends Bloc<FavouriteMoviesEvent, FavouriteMoviesState> {
  final GetFavoriteMoviesUsecase getFavouriteMoviesUsecase;

  FavouriteMoviesBloc(this.getFavouriteMoviesUsecase)
    : super(InitFavouriteMoviesState()) {
    on<FetchFavouriteMoviesEvent>(_onFetchFavouriteMovies);
  }

  Future<void> _onFetchFavouriteMovies(
    FetchFavouriteMoviesEvent event,
    Emitter<FavouriteMoviesState> emit,
  ) async {
    emit(FavouriteMoviesLoadingState());

    final movies = await getFavouriteMoviesUsecase();
    emit(FavouriteMoviesLoadedState(movies: movies));
  }
}

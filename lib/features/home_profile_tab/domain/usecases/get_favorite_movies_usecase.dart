import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart"
    show Movie;
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/repositories/profile_tab_repository.dart";

/// Use case for fetching favorite movies.
class GetFavoriteMoviesUsecase {
  final ProfileTabRepository repository;

  const GetFavoriteMoviesUsecase(this.repository);

  /// Calls the repository to fetch favorite movies.
  ///
  /// Returns a list of favorite [Movie] entities.
  Future<List<Movie>> call() async {
    return await repository.getFavoriteMovies();
  }
}

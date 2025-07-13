import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/repositories/discover_repository.dart";

/// Use case for fetching favorite movies.
class GetFavoriteMoviesUsecase {
  final DiscoverRepository repository;

  /// Creates a new instance of [GetFavoriteMoviesUsecase].
  ///
  /// Requires a [DiscoverRepository] implementation.
  const GetFavoriteMoviesUsecase(this.repository);

  /// Calls the repository to fetch favorite movies.
  ///
  /// Returns a list of favorite [Movie] entities.
  Future<List<Movie>> call() async {
    return await repository.getFavoriteMovies();
  }
}

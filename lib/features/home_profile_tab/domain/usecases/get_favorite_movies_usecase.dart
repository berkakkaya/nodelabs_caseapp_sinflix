import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
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
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing GetFavoriteMoviesUsecase");

    return await repository.getFavoriteMovies();
  }
}

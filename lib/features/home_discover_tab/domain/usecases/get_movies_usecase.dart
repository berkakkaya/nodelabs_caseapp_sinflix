import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie_pagination.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/repositories/discover_repository.dart";

/// Use case for fetching movies with pagination.
class GetMoviesUsecase {
  final DiscoverRepository repository;

  /// Creates a new instance of [GetMoviesUsecase].
  ///
  /// Requires a [DiscoverRepository] implementation.
  const GetMoviesUsecase(this.repository);

  /// Calls the repository to fetch movies with the given pagination.
  ///
  /// [pagination] - The pagination parameter to fetch the next set of movies.
  /// Returns a list of [Movie] entities.
  Future<MoviePagination> call({required int pagination}) async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing GetMoviesUsecase with pagination: $pagination");

    return await repository.getMovies(pagination: pagination);
  }
}

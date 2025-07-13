import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart"
    show LoggingService;
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/repositories/discover_repository.dart";

/// Use case for toggling the favorite status of a movie.
class ToggleFavoriteUsecase {
  final DiscoverRepository repository;

  /// Creates a new instance of [ToggleFavoriteUsecase].
  ///
  /// Requires a [DiscoverRepository] implementation.
  const ToggleFavoriteUsecase(this.repository);

  /// Calls the repository to toggle the favorite status of a movie.
  ///
  /// [movieId] - The ID of the movie to toggle favorite status.
  /// Returns a boolean indicating whether the movie is now favorited (true)
  /// or not (false).
  Future<bool> call(String movieId) async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing ToggleFavoriteUsecase for movieId: $movieId");

    return await repository.toggleFavorite(movieId);
  }
}

import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart"
    show Movie;

abstract class ProfileTabRepository {
  /// Fetches a list of favorite movies.
  Future<List<Movie>> getFavoriteMovies();
}

import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie_pagination.dart";

/// Repository interface for managing movie data.
///
/// This repository provides methods to fetch movies, toggle favorites,
/// and retrieve favorite movies.
abstract class DiscoverRepository {
  /// Fetches a list of movies with pagination support.
  Future<MoviePagination> getMovies({required int pagination});

  /// Toggles favorite status for a movie by its ID.
  Future<bool> toggleFavorite(String movieId);
}

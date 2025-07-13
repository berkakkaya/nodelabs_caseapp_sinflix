import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/models/movie_model.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/models/movie_pagination.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie_pagination.dart";

/// Interface for the Movie data source that connects to the API.
abstract class MovieDatasource {
  /// Fetches movies with pagination support.
  ///
  /// [pagination] - The page number to fetch.
  /// Returns a [MoviePagination] object containing the movies and pagination
  /// info.
  Future<MoviePagination> getMovies({required int pagination});

  /// Toggles the favorite status of a movie by its ID.
  ///
  /// [movieId] - The ID of the movie to toggle favorite status.
  /// Returns true if the movie is favorited, false otherwise.
  Future<bool> toggleFavorite(String movieId);

  /// Fetches a list of favorite movies.
  Future<List<Movie>> getFavoriteMovies();
}

/// Implementation of [MovieDatasource] that connects to the API using
/// [RestApiService].
class MovieDatasourceImpl implements MovieDatasource {
  final RestApiService _apiService;

  MovieDatasourceImpl({required RestApiService apiService})
    : _apiService = apiService;

  @override
  Future<MoviePagination> getMovies({required int pagination}) async {
    if (pagination < 1) {
      throw ArgumentError("Pagination must greater than 0");
    }

    final response = await _apiService.get(
      "/movie/list",
      queryParameters: {"page": pagination},
    );

    if (response.isOk && response.data != null) {
      return MoviePaginationModel.fromJson(response.data!["data"]);
    } else {
      throw Exception("Failed to fetch movies: ${response.statusCode}");
    }
  }

  @override
  Future<bool> toggleFavorite(String movieId) async {
    final response = await _apiService.post("/movie/favorite/$movieId");

    if (response.isOk && response.data != null) {
      final jsonData = response.data!;
      return jsonData["data"]["action"] != "unfavorited";
    } else {
      throw Exception("Failed to toggle favorite: ${response.statusCode}");
    }
  }

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    final response = await _apiService.get("/movie/favorites");

    if (response.isOk && response.data != null) {
      final jsonData = response.data!;

      if (jsonData["data"] != null && jsonData["data"] is List) {
        return (jsonData["data"] as List)
            .map(
              (movieJson) =>
                  MovieModel.fromJson(movieJson as Map<String, dynamic>),
            )
            .toList();
      }

      return [];
    } else {
      throw Exception(
        "Failed to fetch favorite movies: ${response.statusCode}",
      );
    }
  }
}

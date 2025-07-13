import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart"
    show RestApiService;
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/data/models/movie_model.dart"
    show MovieModel;
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart"
    show Movie;

abstract class ProfileTabDatasource {
  /// Fetches a list of favorite movies.
  Future<List<Movie>> getFavoriteMovies();
}

class ProfileTabDatasourceImpl implements ProfileTabDatasource {
  final RestApiService _apiService;

  ProfileTabDatasourceImpl({required RestApiService apiService})
    : _apiService = apiService;

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

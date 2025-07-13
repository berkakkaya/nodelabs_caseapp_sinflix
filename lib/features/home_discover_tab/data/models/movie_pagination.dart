import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/models/movie_model.dart"
    show MovieModel;
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie_pagination.dart"
    show MoviePagination;

class MoviePaginationModel extends MoviePagination {
  const MoviePaginationModel({
    required super.currentPage,
    required super.totalPages,
    required super.movies,
  });

  /// Creates a new instance of [MoviePaginationModel] from a JSON map.
  factory MoviePaginationModel.fromJson(Map<String, dynamic> json) {
    final int currentPage = json["pagination"]["currentPage"];
    final int totalPages = json["pagination"]["maxPage"];

    final List<MovieModel> movies = (json["movies"] as List)
        .map((movieJson) => MovieModel.fromJson(movieJson))
        .toList();

    return MoviePaginationModel(
      currentPage: currentPage,
      totalPages: totalPages,
      movies: movies,
    );
  }
}

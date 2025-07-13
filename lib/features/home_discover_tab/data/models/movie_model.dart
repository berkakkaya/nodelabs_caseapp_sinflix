import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";

class MovieModel extends Movie {
  const MovieModel({
    required super.movieId,
    required super.posterUrl,
    required super.title,
    required super.description,
    required super.isFavorite,
  });

  /// Creates a [MovieModel] from a JSON map.
  ///
  /// The JSON map should contain the keys "id", "Poster", "Title", and "Plot".
  /// It also attempts to extract a valid poster URL from the "Images" list if
  /// available and skips any URLs that contain the word "imdb".
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final List<String> posterCandidates = [json["Poster"] as String];
    posterCandidates.addAll((json["Images"]).cast<String>());

    // Skip any links that contains the word "imdb"
    final String posterUrl = posterCandidates.firstWhere(
      (url) => !url.contains("imdb"),
      orElse: () => posterCandidates.first,
    );

    return MovieModel(
      movieId: json["id"] as String,
      posterUrl: posterUrl,
      title: json["Title"] as String,
      description: json["Plot"] as String,
      isFavorite: json["isFavorite"] as bool? ?? false,
    );
  }
}

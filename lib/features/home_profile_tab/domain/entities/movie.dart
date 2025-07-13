import "package:equatable/equatable.dart";

class Movie extends Equatable {
  final String movieId;
  final String posterUrl;
  final String title;
  final String description;
  final bool isFavorite;

  const Movie({
    required this.movieId,
    required this.posterUrl,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
    movieId,
    posterUrl,
    title,
    description,
    isFavorite,
  ];
}

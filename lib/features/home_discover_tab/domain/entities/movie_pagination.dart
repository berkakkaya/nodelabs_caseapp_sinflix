import "package:equatable/equatable.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie.dart";

class MoviePagination extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<Movie> movies;

  const MoviePagination({
    required this.currentPage,
    required this.totalPages,
    required this.movies,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, movies];
}

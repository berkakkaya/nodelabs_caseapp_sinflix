import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/data/datasources/movie_datasource.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/entities/movie_pagination.dart";
import "package:nodelabs_caseapp_sinflix/features/home_discover_tab/domain/repositories/discover_repository.dart";

/// Implementation of [DiscoverRepository] that uses a [MovieDatasource]
/// to fetch and manage movie data.
class DiscoverRepositoryImpl implements DiscoverRepository {
  final MovieDatasource _dataSource;

  /// Creates a new instance of [DiscoverRepositoryImpl].
  ///
  /// [dataSource] - The data source for movie data.
  const DiscoverRepositoryImpl({required MovieDatasource dataSource})
    : _dataSource = dataSource;

  @override
  Future<MoviePagination> getMovies({required int pagination}) async {
    return await _dataSource.getMovies(pagination: pagination);
  }

  @override
  Future<bool> toggleFavorite(String movieId) async {
    return await _dataSource.toggleFavorite(movieId);
  }
}

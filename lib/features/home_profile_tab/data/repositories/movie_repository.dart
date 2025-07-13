import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart"
    show Movie;
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/repositories/profile_tab_repository.dart";

class ProfileTabRepositoryImpl implements ProfileTabRepository {
  final ProfileTabRepository _dataSource;

  /// Creates a new instance of [DiscoverRepositoryImpl].
  ///
  /// [dataSource] - The data source for movie data.
  const ProfileTabRepositoryImpl({required ProfileTabRepository dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    return await _dataSource.getFavoriteMovies();
  }
}

import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/data/datasources/profile_tab_datasource.dart";
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/entities/movie.dart"
    show Movie;
import "package:nodelabs_caseapp_sinflix/features/home_profile_tab/domain/repositories/profile_tab_repository.dart";

class ProfileTabRepositoryImpl implements ProfileTabRepository {
  final ProfileTabDatasource _dataSource;

  const ProfileTabRepositoryImpl({required ProfileTabDatasource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    return await _dataSource.getFavoriteMovies();
  }
}

import "package:get_it/get_it.dart" show GetIt;
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart"
    show RestApiService;
import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// A use case class responsible for retrieving the currently authenticated
/// user.
///
/// This class interacts with the [UserRepository] to fetch the current user,
/// if any, from the underlying data source.
///
/// Returns a [User] object if a user is currently authenticated, or `null`
/// otherwise. If user data couldn't be retrieved, it will also sign out the
/// user by calling the [signOut] method of the [UserRepository] and clear the
/// token in the [RestApiService].
class GetCurrentUserUseCase {
  /// The repository used to perform user-related operations.
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> execute() async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing GetCurrentTokenUseCase");

    final user = await repository.getCurrentUser();

    // If user could not be retrieved, log out the user
    if (user == null) {
      logger.w("GetCurrentTokenUseCase: No user found, signing out.");
      await repository.signOut();

      final apiService = GetIt.I.get<RestApiService>();
      apiService.setToken(null);
    }

    return user;
  }
}

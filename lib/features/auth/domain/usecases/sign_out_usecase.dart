import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart"
    show RestApiService;
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// A use case class responsible for signing out the current user.
///
/// This class interacts with the [UserRepository] to perform the sign-out
/// operation. After signing out, it also clears the authentication token
/// from local storage using [LocalStorageService] and the API service.
class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing SignOutUseCase");

    await repository.signOut();

    // Clear the token in the RestApiService
    final apiService = GetIt.I.get<RestApiService>();
    apiService.setToken(null);

    // Clear the token from the local storage
    final localStorageService = GetIt.I.get<LocalStorageService>();
    await localStorageService.setToken(null);
  }
}

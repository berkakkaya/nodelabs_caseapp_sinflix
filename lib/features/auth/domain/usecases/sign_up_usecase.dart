import "package:get_it/get_it.dart" show GetIt;
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// A use case class responsible for handling user sign-up logic.
///
/// This class interacts with the [UserRepository] to perform the sign-up
/// operation. Upon successful sign-up, it sets the authentication token in
/// both [RestApiService] and [LocalStorageService] for subsequent API requests
/// and local persistence.
///
/// Returns the signed-up [User] if successful, otherwise returns `null`.
class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase(this.repository);

  Future<User?> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing SignInUseCase with email: $email");

    final user = await repository.signUp(
      nameSurname: name,
      email: email,
      password: password,
    );

    if (user != null) {
      // Set the token in the RestApiService and LocalStorageService
      final apiService = GetIt.I.get<RestApiService>();
      final localStorageService = GetIt.I.get<LocalStorageService>();

      apiService.setToken(user.token);
      await localStorageService.setToken(user.token);
    }

    return user;
  }
}

import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// A use case class responsible for handling user sign-in logic.
///
/// This class interacts with the [UserRepository] to authenticate a user
/// using their email and password. Upon successful authentication, it sets
/// the user's token in the [RestApiService] for subsequent API requests and
/// saves the token in the [LocalStorageService] for persistence.
class SignInUseCase {
  /// The repository used to perform user-related operations.
  final UserRepository repository;

  SignInUseCase(this.repository);

  /// Executes the sign-in operation with the provided email and password.
  Future<User?> execute({
    required String email,
    required String password,
  }) async {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing SignInUseCase with email: $email");

    final user = await repository.signIn(email: email, password: password);

    if (user != null) {
      final apiService = GetIt.I.get<RestApiService>();
      final localStorageService = GetIt.I.get<LocalStorageService>();

      apiService.setToken(user.token);
      await localStorageService.setToken(user.token);
    }

    return user;
  }
}

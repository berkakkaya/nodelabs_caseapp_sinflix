import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// A use case that checks whether a user is currently signed in.
///
/// This class depends on a [UserRepository] to determine the authentication
/// state.
///
/// Returns `true` if the user is signed in, otherwise `false`.
class IsSignedInUseCase {
  final UserRepository repository;

  IsSignedInUseCase(this.repository);

  Future<bool> execute() {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing IsSignedInUseCase");

    return repository.isSignedIn();
  }
}

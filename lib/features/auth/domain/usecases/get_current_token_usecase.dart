import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart"
    show UserRepository;

/// A use case that retrieves the current authentication token.
///
/// This class depends on a [UserRepository] to fetch the current token.
/// Returns the current token as a [String] if available, or `null` if not.
class GetCurrentTokenUseCase {
  final UserRepository repository;

  GetCurrentTokenUseCase(this.repository);

  Future<String?> execute() {
    final logger = GetIt.instance.get<LoggingService>();
    logger.i("Executing GetCurrentTokenUseCase");

    return repository.getCurrentToken();
  }
}

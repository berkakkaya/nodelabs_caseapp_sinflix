import "dart:typed_data";

import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

class UploadProfilePhotoUseCase {
  final UserRepository repository;

  UploadProfilePhotoUseCase(this.repository);

  Future<String?> execute(Uint8List bytes, {required String filename}) {
    final logger = GetIt.I.get<LoggingService>();
    logger.i("Executing UploadProfilePhotoUseCase with filename: $filename");

    return repository.uploadProfilePhoto(bytes, filename);
  }
}

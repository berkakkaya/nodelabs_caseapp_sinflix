import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

class UploadProfilePhotoUseCase {
  final UserRepository repository;

  UploadProfilePhotoUseCase(this.repository);

  Future<String?> execute(Uint8List bytes, {required String filename}) {
    return repository.uploadProfilePhoto(bytes, filename);
  }
}

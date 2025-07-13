import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/repositories/profile_photo_repository.dart";

/// Use case for uploading a profile photo.
///
/// This use case encapsulates the logic for uploading a profile photo
/// to the server.
class UploadProfilePhotoUseCase {
  final ProfilePhotoRepository repository;

  UploadProfilePhotoUseCase(this.repository);

  /// Executes the use case with the specified image bytes and file name.
  ///
  /// Returns the URL of the uploaded photo if successful, otherwise null.
  Future<String?> execute(Uint8List bytes, {required String fileName}) {
    return repository.uploadProfilePhoto(bytes, fileName);
  }
}

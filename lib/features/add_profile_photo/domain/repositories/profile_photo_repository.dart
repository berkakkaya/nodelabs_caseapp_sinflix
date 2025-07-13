import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_details.dart"
    show ImageDetails;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_source.dart"
    show ImageSource;

/// Interface for profile photo operations.
///
/// This repository defines the contract for profile photo-related operations
/// such as selecting and uploading a profile photo.
///
/// It abstracts the underlying data source implementation, allowing for
/// flexibility in how profile photos are handled.
abstract class ProfilePhotoRepository {
  /// Picks an image from the gallery or camera.
  ///
  /// Returns a tuple containing the file bytes, file name, and mime type.
  /// Returns null if the user cancels the operation.
  Future<ImageDetails?> pickImage({required ImageSource source});

  /// Uploads a profile photo to the server.
  ///
  /// Returns the URL of the uploaded photo if successful, otherwise null.
  Future<String?> uploadProfilePhoto(Uint8List bytes, String fileName);
}

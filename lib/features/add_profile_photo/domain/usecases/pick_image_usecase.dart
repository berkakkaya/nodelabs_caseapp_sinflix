import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_details.dart"
    show ImageDetails;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_source.dart"
    show ImageSource;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/repositories/profile_photo_repository.dart";

/// Use case for picking an image from the gallery or camera.
///
/// This use case encapsulates the logic for selecting an image
/// from either the gallery or the camera.
class PickImageUseCase {
  final ProfilePhotoRepository repository;

  PickImageUseCase(this.repository);

  /// Executes the use case with the specified image source.
  ///
  /// Returns an [ImageDetails] object if an image was selected,
  /// otherwise returns null.
  Future<ImageDetails?> execute({required ImageSource source}) {
    return repository.pickImage(source: source);
  }
}

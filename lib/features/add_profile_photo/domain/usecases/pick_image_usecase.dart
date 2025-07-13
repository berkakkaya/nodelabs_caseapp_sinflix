import "package:get_it/get_it.dart" show GetIt;
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart"
    show LoggingService;
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
    final logger = GetIt.instance.get<LoggingService>();
    logger.i("Executing PickImageUseCase with source: $source");

    return repository.pickImage(source: source);
  }
}

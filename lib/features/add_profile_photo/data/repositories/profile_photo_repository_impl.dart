import "dart:typed_data";

import "package:image_picker/image_picker.dart" as image_picker;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_details.dart"
    show ImageDetails;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_source.dart"
    show ImageSource;
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/repositories/profile_photo_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

/// Implementation of the [ProfilePhotoRepository] that uses the [ImagePicker]
/// library for picking images and the [UserRepository] for uploading photos.
class ProfilePhotoRepositoryImpl implements ProfilePhotoRepository {
  final image_picker.ImagePicker _imagePicker;
  final UserRepository _userRepository;

  ProfilePhotoRepositoryImpl({
    required image_picker.ImagePicker imagePicker,
    required UserRepository userRepository,
  }) : _imagePicker = imagePicker,
       _userRepository = userRepository;

  @override
  Future<ImageDetails?> pickImage({required ImageSource source}) async {
    final image_picker.XFile? pickedFile = await _imagePicker.pickImage(
      source: source == ImageSource.gallery
          ? image_picker.ImageSource.gallery
          : image_picker.ImageSource.camera,
      preferredCameraDevice: source == ImageSource.camera
          ? image_picker.CameraDevice.front
          : image_picker.CameraDevice.rear,
    );

    if (pickedFile == null) {
      return null;
    }

    // Read the file as bytes
    final bytes = await pickedFile.readAsBytes();

    // Get file name and detect mime type
    final fileName = pickedFile.name;
    final mimeType = _detectMimeType(bytes);

    return ImageDetails(bytes: bytes, fileName: fileName, mimeType: mimeType);
  }

  @override
  Future<String?> uploadProfilePhoto(Uint8List bytes, String fileName) {
    return _userRepository.uploadProfilePhoto(bytes, fileName);
  }

  /// Detects the MIME type of an image based on its byte content.
  ///
  /// Function checks the first few bytes of the image data
  /// to identify the format, which is a common method for MIME type detection.
  /// JPEG images start with the bytes `0xFF, 0xD8` and PNG images start with
  /// the bytes `0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A`.
  ///
  /// If JPEG image is detected, it returns "image/jpeg". If PNG image is
  /// detected, it returns "image/png".
  String _detectMimeType(Uint8List bytes) {
    assert(bytes.isNotEmpty, "Byte array cannot be empty");
    if (bytes.isEmpty) return "application/octet-stream";

    // Check for JPEG magic number
    if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return "image/jpeg";
    }

    // Check for PNG magic number
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47 &&
        bytes[4] == 0x0D &&
        bytes[5] == 0x0A &&
        bytes[6] == 0x1A &&
        bytes[7] == 0x0A) {
      return "image/png";
    }

    // Return a generic mimetype for all file types
    return "application/octet-stream";
  }
}

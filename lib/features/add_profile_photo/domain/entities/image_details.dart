import "dart:typed_data";

/// Class representing the details of an image.
class ImageDetails {
  final Uint8List bytes;
  final String fileName;
  final String mimeType;

  const ImageDetails({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });
}

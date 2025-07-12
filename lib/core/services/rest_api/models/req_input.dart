import "package:equatable/equatable.dart";

/// Represents the type of input for a REST API request.
enum ReqInputType {
  /// Represents a JSON input type.
  json,

  /// Represents a file upload input type.
  fileUpload,
}

/// Represents a file upload with its bytes, name, and MIME type.
class FileUpload {
  /// The file's bytes.
  final List<int> bytes;

  /// The name of the file.
  final String fileName;

  /// The MIME type of the file.
  final String mimeType;

  /// Creates a [FileUpload] with the specified [bytes], [fileName],
  /// and [mimeType].
  const FileUpload({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });
}

/// Represents the input for a REST API request.
class ReqInput extends Equatable {
  /// The type of input for the request.
  final ReqInputType type;

  /// The data to be sent in the request.
  final Map<String, dynamic> data;

  /// Creates a [ReqInput] with the specified [type] and [data].
  const ReqInput({required this.type, required this.data});

  @override
  List<Object?> get props => [type, data];

  @override
  String toString() => "ReqInput(type: $type, data: $data)";
}

import "package:equatable/equatable.dart";

/// Represents the type of input for a REST API request.
enum ReqInputType {
  /// Represents a JSON input type.
  json,

  /// Represents a file upload input type.
  fileUpload,
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

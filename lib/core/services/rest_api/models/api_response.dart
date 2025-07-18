import "package:equatable/equatable.dart";

typedef JsonResponse = Map<String, dynamic>;

/// Base sealed class representing a generic API response.
///
/// Contains optional [data] and [statusCode].
/// Ensures [statusCode] is within the valid HTTP range (100-599).
sealed class ApiResponse<T> extends Equatable {
  /// The data returned from the API, if any.
  final T? data;

  /// The HTTP status code of the response.
  /// Must be between 100 and 599 if provided.
  final int? statusCode;

  /// Creates an [ApiResponse] with the given [data] and
  /// [statusCode].
  ///
  /// Throws an [AssertionError] if [statusCode] is not within 100-599.
  const ApiResponse({required this.data, this.statusCode})
    : assert(
        statusCode == null || (statusCode >= 100 && statusCode <= 599),
        "statusCode must be between 100 and 599",
      );

  /// Returns `true` if [statusCode] is in the 2xx range, indicating success.
  bool get isOk {
    if (statusCode == null) return false;
    return statusCode! >= 200 && statusCode! < 300;
  }

  /// Transforms the [data] using the provided [transform] function.
  ///
  /// The [transform] function should take the original data type [T]
  /// and return a new type [D]. Transformation function is only applied
  /// if [data] is not null.
  ///
  /// Returns a new [ApiResponse] with the transformed data.
  ApiResponse<D>? transform<D>(D Function(T rawData) transform);

  @override
  List<Object?> get props => [data, statusCode];

  @override
  String toString();
}

/// Represents a successful API response.
///
/// Always returns `true` for [isOk].
class ApiSuccessRes<T> extends ApiResponse<T> {
  /// Creates an [ApiSuccessRes] with the given [data] and [statusCode].
  const ApiSuccessRes({required T super.data, required int super.statusCode})
    : assert(
        statusCode >= 200 && statusCode < 400,
        "statusCode must be in between the 2xx and 4xx range for success responses",
      );

  @override
  ApiSuccessRes<D>? transform<D>(D Function(T rawData) transform) {
    if (data == null) {
      return null;
    }

    final transformedData = transform(data as T);
    return ApiSuccessRes<D>(data: transformedData, statusCode: statusCode!);
  }

  /// Always returns `true` to indicate a successful response.
  @override
  bool get isOk => true;

  @override
  String toString() {
    return "ApiSuccessRes(data: $data, statusCode: $statusCode)";
  }
}

/// Represents an error API response.
///
/// Always returns `false` for [isOk].
class ApiErrorRes<T> extends ApiResponse<T> {
  /// Creates an [ApiErrorRes] with optional [data] and optional [statusCode].
  const ApiErrorRes({super.data, super.statusCode})
    : assert(
        statusCode == null || (statusCode >= 400 && statusCode < 600),
        "statusCode must be in the 4xx or 5xx range for error responses",
      );

  /// Always returns `false` to indicate an error response.
  @override
  bool get isOk => false;

  @override
  ApiErrorRes<D>? transform<D>(D Function(T rawData) transform) {
    if (data == null) {
      return null;
    }

    final transformedData = transform(data as T);
    return ApiErrorRes<D>(data: transformedData, statusCode: statusCode);
  }

  @override
  String toString() {
    return "ApiErrorRes(data: $data, statusCode: $statusCode)";
  }
}

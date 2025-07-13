import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/api_response.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/req_input.dart";

/// Interface for REST API service.
///
/// Provides methods for making GET and POST requests.
///
/// Also provides getter and setter for the authentication token.
abstract class RestApiService {
  /// Runs a GET request to the specified [path].
  ///
  /// [queryParameters] and [headers] are optional parameters for the request.
  Future<ApiResponse<JsonResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Runs a POST request to the specified [path] with the given [data].
  ///
  /// [data] is an instance of [ReqInput] that specifies the type of input
  /// (JSON or form data) and the data to be sent. [queryParameters] and
  /// [headers] are optional parameters for the request.
  Future<ApiResponse<JsonResponse>> post(
    String path, {
    ReqInput? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Returns the current authentication token.
  String? get token;

  /// Sets the authentication token.
  void setToken(String? token);
}

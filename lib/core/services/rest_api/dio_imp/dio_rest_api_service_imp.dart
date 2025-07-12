import "package:dio/dio.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/api_response.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/req_input.dart";

/// Implementation of [RestApiService] using Dio HTTP client.
class DioRestApiServiceImp implements RestApiService {
  /// Dio HTTP client instance
  final Dio _dio;

  /// Base URL for all API requests
  final String baseUrl;

  /// Authentication token
  String? _token;

  /// Creates a new [DioRestApiServiceImp] with required [baseUrl] and optional
  /// [dio] instance.
  ///
  /// If [dio] is not provided, a new instance will be created with default
  /// options.
  DioRestApiServiceImp({required this.baseUrl, Dio? dio, BaseOptions? options})
    : _dio = dio ?? Dio() {
    // Configure Dio instance
    if (options != null) {
      _dio.options = options;
      _dio.options.baseUrl = baseUrl;
    } else {
      /// Set default options for Dio
      /// This includes base URL, timeouts, and status code validation.
      _dio.options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (status) =>
            status != null &&
            status >= 200 &&
            status < 400, // Only consider 2xx and 3xx as valid
      );
    }
  }

  @override
  String? get token => _token;

  @override
  void setToken(String? token) {
    _token = token;
  }

  /// Adds authentication headers if a token is available
  Map<String, String> _getAuthHeaders() {
    return _token != null ? {"Authorization": "Bearer $_token"} : {};
  }

  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      // Merge auth headers with provided headers
      final mergedHeaders = {..._getAuthHeaders(), ...(headers ?? {})};

      final res = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      return ApiSuccessRes(data: res.data, statusCode: res.statusCode!);
    } catch (e) {
      if (e is DioException) {
        return ApiErrorRes(
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      }

      return ApiErrorRes();
    }
  }

  @override
  Future<ApiResponse> post(
    String path, {
    ReqInput? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      // Merge auth headers with provided headers
      final mergedHeaders = {..._getAuthHeaders(), ...(headers ?? {})};

      // Process request data based on input type
      dynamic requestData;

      if (data != null) {
        if (data.type == ReqInputType.json) {
          requestData = data.data;
          mergedHeaders["Content-Type"] = "application/json";
        } else if (data.type == ReqInputType.fileUpload) {
          final formData = FormData();
          for (final entry in data.data.entries) {
            if (entry.value is List<int>) {
              // Assuming entry.value is a file's bytes
              formData.files.add(
                MapEntry(
                  entry.key,
                  MultipartFile.fromBytes(entry.value, filename: entry.key),
                ),
              );
            } else if (entry.value is MultipartFile) {
              formData.files.add(MapEntry(entry.key, entry.value));
            } else {
              formData.fields.add(MapEntry(entry.key, entry.value.toString()));
            }
          }

          requestData = formData;
        }
      }

      final response = await _dio.post<dynamic>(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      return ApiSuccessRes(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } catch (e) {
      if (e is DioException) {
        return ApiErrorRes(
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      }

      return ApiErrorRes();
    }
  }
}

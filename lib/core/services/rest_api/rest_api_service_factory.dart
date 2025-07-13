import "package:dio/dio.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/dio_imp/dio_rest_api_service_imp.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";

/// Factory for creating REST API service instances.
class RestApiServiceFactory {
  /// Creates a new REST API service instance using Dio implementation.
  static RestApiService createDioService({
    required String baseUrl,
    Dio? dio,
    BaseOptions? options,
  }) {
    return DioRestApiServiceImp(baseUrl: baseUrl, dio: dio, options: options);
  }
}

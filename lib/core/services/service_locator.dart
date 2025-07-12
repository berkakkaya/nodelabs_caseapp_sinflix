import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/api_config.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/rest_api_service_factory.dart";

/// Initializes the service locator with required services.
Future<void> initializeResources() async {
  final getIt = GetIt.instance;

  // Register the Dio REST API service
  getIt.registerLazySingleton<RestApiService>(
    () => RestApiServiceFactory.createDioService(baseUrl: kApiBaseUrl),
  );
}

import "package:dio/dio.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/api_config.dart";
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart"
    show LocalStorageService;
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/shared_pref_imp/local_storage_shared_pref_imp.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/talker_imp/talker_logging_service_imp.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/rest_api_service_factory.dart";
import "package:talker_bloc_logger/talker_bloc_logger.dart";
import "package:talker_dio_logger/talker_dio_logger.dart";

/// Mode for serice locator resources.
///
/// This enum defines the mode of operation for the service locator,
/// determining whether to use real or mock resources.
///
/// Currently, only [useRealResources] is implemented.
/// [useMockResources] is a placeholder for future use.
enum ResourceMode {
  /// Use real resources, such as a live API and database.
  useRealResources,

  /// Use mock resources, such as a mock API and in-memory database.
  /// This is useful for testing and development without relying on
  /// external services.
  ///
  /// NOTE: This option doesn't currently have an implementation and put
  /// as a placeholder for future use.
  useMockResources,
}

/// Initializes the service locator with required services.
///
/// These services include the REST API service and any other
/// dependencies needed by the application.
///
/// These services are registered with the [GetIt] instance
/// and can be accessed throughout the application using
/// the same [GetIt] instance.
Future<void> initializeResources({
  ResourceMode mode = ResourceMode.useRealResources,
}) async {
  final getIt = GetIt.instance;

  // Initialize the logging service
  final loggingService = TalkerLoggingService.withDefaults();
  getIt.registerSingleton<LoggingService>(loggingService);

  loggingService.i("Initializing BLoC Talker service...");

  // Register BLoC observer for logging
  Bloc.observer = TalkerBlocObserver(talker: loggingService.talker);

  loggingService.i("Initializing REST API service...");

  // Register the Dio REST API service
  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(talker: loggingService.talker));

  getIt.registerSingleton<RestApiService>(
    RestApiServiceFactory.createDioService(dio: dio, baseUrl: kApiBaseUrl),
  );

  loggingService.i("REST API service registered");

  // Initialize the local storage service
  final localStorageService = await LocalStorageSharedPrefsImp.withDefaults();
  getIt.registerSingleton<LocalStorageService>(localStorageService);

  loggingService.i("Local storage service registered");

  loggingService.i("All services initialized successfully");
}

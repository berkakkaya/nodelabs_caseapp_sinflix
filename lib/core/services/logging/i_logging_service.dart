/// Interface for the logging service
/// This service is responsible for logging messages, errors, exceptions
/// and providing a Talker instance for use in other services.
abstract class LoggingService {
  /// Log verbose message
  void v(String message, [Object? error, StackTrace? stackTrace]);

  /// Log debug message
  void d(String message, [Object? error, StackTrace? stackTrace]);

  /// Log info message
  void i(String message, [Object? error, StackTrace? stackTrace]);

  /// Log warning message
  void w(String message, [Object? error, StackTrace? stackTrace]);

  /// Log error message
  void e(String message, [Object? error, StackTrace? stackTrace]);

  /// Log critical error message
  void critical(String message, [Object? error, StackTrace? stackTrace]);

  /// Log an exception
  void exception(Object exception, [StackTrace? stackTrace]);

  /// Handle uncaught errors in the application
  void handleUncaughtError(Object error, StackTrace stackTrace);
}

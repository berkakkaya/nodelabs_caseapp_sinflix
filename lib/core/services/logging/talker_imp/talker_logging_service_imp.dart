import "package:flutter/foundation.dart";
import "package:talker_flutter/talker_flutter.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";

/// Implementation of the [LoggingService] using Talker package
class TalkerLoggingService implements LoggingService {
  /// Talker instance for logging
  final Talker _talker;

  /// Creates a new [TalkerLoggingService] with default settings
  TalkerLoggingService({Talker? talker}) : _talker = talker ?? Talker();

  /// Factory method to create a [TalkerLoggingService] with default configuration
  ///
  /// This includes:
  /// - A talker instance with a custom configuration
  /// - Observer for uncaught errors in debug mode
  factory TalkerLoggingService.withDefaults() {
    final talker = Talker(
      settings: TalkerSettings(
        useHistory: true,
        maxHistoryItems: 1000,
        enabled: true,
      ),
      logger: TalkerLogger(
        settings: TalkerLoggerSettings(
          enableColors: true,
          level: LogLevel.debug,
        ),
      ),
    );

    // Set up error handling in debug mode
    if (kDebugMode) {
      FlutterError.onError = (details) {
        talker.handle(details.exception, details.stack);
      };
    }

    return TalkerLoggingService(talker: talker);
  }

  Talker get talker => _talker;

  @override
  void v(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.verbose(message, error, stackTrace);
  }

  @override
  void d(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.debug(message, error, stackTrace);
  }

  @override
  void i(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.info(message, error, stackTrace);
  }

  @override
  void w(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.warning(message, error, stackTrace);
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.error(message, error, stackTrace);
  }

  @override
  void critical(String message, [Object? error, StackTrace? stackTrace]) {
    _talker.critical(message, error, stackTrace);
  }

  @override
  void exception(Object exception, [StackTrace? stackTrace]) {
    _talker.handle(exception, stackTrace);
  }

  @override
  void handleUncaughtError(Object error, StackTrace stackTrace) {
    _talker.handle(error, stackTrace);
  }
}

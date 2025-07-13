/// Service for storing key-value pairs in local storage.
///
/// This service provides methods to set and get datas in local storage.
///
/// It abstracts the underlying storage mechanism, allowing for easy access
/// to persistent data across app sessions.
abstract class LocalStorageService {
  /// Sets the token in local storage with the given [token].
  ///
  /// Returns a Future that completes when the token is set. If the [token]
  /// is null, it will remove the existing token.
  Future<void> setToken(String? token);

  /// Gets the token from local storage.
  ///
  /// Returns a Future that completes with the token string if it exists,
  /// or null if it does not.
  Future<String?> getToken();
}

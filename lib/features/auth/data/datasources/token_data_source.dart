import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";

/// Data source for managing authentication tokens.
abstract class TokenDataSource {
  /// Saves the authentication token.
  Future<void> saveToken(String token);

  /// Retrieves the authentication token.
  Future<String?> getToken();

  /// Deletes the authentication token.
  Future<void> deleteToken();
}

/// Implementation of the [TokenDataSource], using local storage service.
class TokenDataSourceImpl implements TokenDataSource {
  final LocalStorageService storageService;

  TokenDataSourceImpl({required this.storageService});

  @override
  Future<void> saveToken(String token) async {
    await storageService.setToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await storageService.getToken();
  }

  @override
  Future<void> deleteToken() async {
    await storageService.setToken(null);
  }
}

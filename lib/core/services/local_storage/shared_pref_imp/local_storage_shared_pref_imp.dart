import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:shared_preferences/shared_preferences.dart";

class LocalStorageSharedPrefsImp implements LocalStorageService {
  late final SharedPreferencesWithCache _prefs;

  LocalStorageSharedPrefsImp(this._prefs);

  static Future<LocalStorageSharedPrefsImp> withDefaults() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {"auth_token"},
      ),
    );
    return LocalStorageSharedPrefsImp(prefs);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString("auth_token");
  }

  @override
  Future<void> setToken(String? token) async {
    if (token == null) {
      return await _prefs.remove("auth_token");
    }

    await _prefs.setString("auth_token", token);
  }
}

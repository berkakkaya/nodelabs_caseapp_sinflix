import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/shared_pref_imp/local_storage_shared_pref_imp.dart";
import "package:shared_preferences/shared_preferences.dart";

class LocalStorageServiceFactory {
  static Future<LocalStorageService> createSharedPreferencesService([
    SharedPreferencesWithCache? prefs,
  ]) async {
    if (prefs != null) {
      return LocalStorageSharedPrefsImp(prefs);
    }

    return LocalStorageSharedPrefsImp.withDefaults();
  }
}

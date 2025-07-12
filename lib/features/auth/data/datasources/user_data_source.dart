import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/api_response.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/models/req_input.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/data/models/user_model.dart";

/// An abstract data source for authentication-related and user profile
/// related operations.
///
/// Provides methods for signing in, signing up, retrieving the user profile,
/// and uploading a profile photo.
abstract class UserDataSource {
  /// Signs in a user with the provided [email] and [password].
  ///
  /// Returns a [UserModel] if authentication is successful, otherwise returns
  /// `null`.
  Future<UserModel?> signIn({required String email, required String password});

  /// Registers a new user with the given [name], [email], and [password].
  ///
  /// Returns a [UserModel] if registration is successful, otherwise returns
  /// `null`.
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Retrieves the profile of the currently authenticated user.
  ///
  /// Returns a [UserModel] if the user is authenticated, otherwise returns
  /// `null`.
  Future<UserModel?> getUserProfile();

  /// Uploads a profile photo using the provided [bytes], [fileName], and
  /// [mimeType].
  ///
  /// Returns the URL of the uploaded photo as a [String] if successful,
  /// otherwise returns `null`.
  Future<String?> uploadProfilePhoto(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
  });
}

class UserDataSourceImpl implements UserDataSource {
  final RestApiService apiService;

  UserDataSourceImpl({required this.apiService});

  @override
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};

    final response = await apiService.post(
      "/user/login",
      data: ReqInput(type: ReqInputType.json, data: data),
    );

    if (response is! ApiSuccessRes) {
      return null;
    }

    final String token = response.data!["data"]["token"];
    return UserModel.fromJson(response.data!, token: token);
  }

  @override
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final data = {"name": name, "email": email, "password": password};

    final response = await apiService.post(
      "/user/register",
      data: ReqInput(type: ReqInputType.json, data: data),
    );

    if (response is! ApiSuccessRes) {
      return null;
    }

    final String token = response.data!["data"]["token"];
    return UserModel.fromJson(response.data!, token: token);
  }

  @override
  Future<UserModel?> getUserProfile() async {
    final response = await apiService.get("/user/profile");

    if (response is! ApiSuccessRes) {
      return null;
    }

    return UserModel.fromJson(response.data!["data"]);
  }

  @override
  Future<String?> uploadProfilePhoto(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
  }) async {
    final response = await apiService.post(
      "/user/upload_photo",
      data: ReqInput(
        type: ReqInputType.fileUpload,
        data: {
          "file": FileUpload(
            bytes: bytes,
            fileName: fileName,
            mimeType: mimeType,
          ),
        },
      ),
    );

    if (response is! ApiSuccessRes) {
      return null;
    }

    return response.data!["data"]["photoUrl"];
  }
}

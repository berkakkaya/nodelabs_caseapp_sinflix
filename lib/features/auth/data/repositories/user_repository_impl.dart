import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/features/auth/data/datasources/user_data_source.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/data/datasources/token_data_source.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";

class UserRepositoryImpl implements UserRepository {
  final UserDataSource authDataSource;
  final TokenDataSource tokenDataSource;

  UserRepositoryImpl({
    required this.authDataSource,
    required this.tokenDataSource,
  });

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final userModel = await authDataSource.signIn(
      email: email,
      password: password,
    );

    // Save the token to local storage
    if (userModel != null) {
      await tokenDataSource.saveToken(userModel.token!);
    }

    return userModel;
  }

  @override
  Future<User?> signUp({
    required String nameSurname,
    required String email,
    required String password,
  }) async {
    final userModel = await authDataSource.signUp(
      name: nameSurname,
      email: email,
      password: password,
    );

    // Save the token to local storage
    if (userModel != null) {
      await tokenDataSource.saveToken(userModel.token!);
    }

    return userModel;
  }

  @override
  Future<void> signOut() async {
    await tokenDataSource.deleteToken();
  }

  @override
  Future<User?> getCurrentUser() {
    return authDataSource.getUserProfile();
  }

  @override
  Future<bool> isSignedIn() async {
    final token = await tokenDataSource.getToken();
    return token != null;
  }

  @override
  Future<String?> uploadProfilePhoto(Uint8List bytes, String fileName) {
    return authDataSource.uploadProfilePhoto(
      bytes,
      fileName: fileName,
      mimeType: "image/jpeg",
    );
  }
}

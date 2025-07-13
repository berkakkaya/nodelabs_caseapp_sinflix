import "dart:typed_data";

import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";

/// Repository interface for user related operations.
///
/// This interface defines the contract for authentication-related
/// operations such as signing in, signing up, signing out, and checking
/// if a user is signed in. Also, it includes methods for retrieving the
/// current user and uploading a profile photo.
///
/// It abstracts the underlying data source implementation, allowing for
/// flexibility in how authentication is handled (e.g., local storage, remote
/// API).
abstract class UserRepository {
  /// Signs in a user with the provided email and password.
  Future<User?> signIn({required String email, required String password});

  /// Signs up a new user with the provided details.
  Future<User?> signUp({
    required String nameSurname,
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Retrieves the current user.
  Future<User?> getCurrentUser();

  /// Checks if a user is currently signed in.
  Future<bool> isSignedIn();

  /// Retrieves the current authentication token.
  Future<String?> getCurrentToken();

  /// Uploads a profile photo for the current user.
  Future<String?> uploadProfilePhoto(Uint8List bytes, String fileName);
}

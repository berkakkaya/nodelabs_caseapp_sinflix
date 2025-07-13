import "package:equatable/equatable.dart";

/// Represents a user entity in the application domain.
///
/// This entity encapsulates core user information and is used across
/// the application to represent user data. It serves as the main domain
/// object for user-related operations and business logic.
class User extends Equatable {
  /// Unique identifier for the user.
  final String userId;

  /// Full name and surname of the user.
  final String nameSurname;

  /// Email address of the user, used for authentication and communication.
  final String email;

  /// Optional URL pointing to the user's profile photo.
  /// Can be null if user hasn't uploaded a photo.
  final String? photoUrl;

  /// Authentication token for the user session.
  /// Can be null if user is not currently authenticated.
  final String? token;

  /// Creates a new [User] instance with required and optional attributes.
  ///
  /// [userId], [nameSurname], and [email] are required parameters.
  /// [photoUrl] and [token] are optional and can be null.
  const User({
    required this.userId,
    required this.nameSurname,
    required this.email,
    this.photoUrl,
    this.token,
  });

  /// Creates a copy of this user with the specified attributes replaced.
  ///
  /// Returns a new [User] instance with the same values as this user,
  /// except for the attributes that are explicitly specified.
  User copyWith({
    String? userId,
    String? nameSurname,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return User(
      userId: userId ?? this.userId,
      nameSurname: nameSurname ?? this.nameSurname,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [userId, nameSurname, email, photoUrl, token];
}

import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";

/// Data model representation of a User entity.
///
/// This class extends the domain [User] entity and adds data layer
/// functionality such as JSON serialization and deserialization. It acts as a
/// bridge between the domain layer and external data sources.
class UserModel extends User {
  /// Creates a new [UserModel] with the same parameters as the parent
  /// [User] class.
  const UserModel({
    required super.userId,
    required super.nameSurname,
    required super.email,
    super.photoUrl,
    super.token,
  });

  /// Creates a [UserModel] from a JSON map.
  ///
  /// The [json] parameter contains the data from an external source.
  /// The optional [token] parameter allows injecting an authentication token
  /// that may come from a different source than the JSON data.
  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    final String? tokenFromJson = json["token"];
    final String? profilePhotoUrl = json["photoUrl"];

    return UserModel(
      userId: json["id"] ?? "",
      nameSurname: json["name"] ?? "",
      email: json["email"] ?? "",
      photoUrl: profilePhotoUrl?.isEmpty == true ? null : profilePhotoUrl,
      token: token ?? tokenFromJson,
    );
  }

  /// Converts this model to a JSON map for external data storage or API
  /// requests.
  ///
  /// Note that the token is intentionally not included in the JSON output
  /// as it's typically handled separately in authentication flows.
  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "name": nameSurname,
      "email": email,
      "photoUrl": photoUrl,
    };
  }

  /// Creates a [UserModel] from a domain [User] entity.
  ///
  /// This factory method facilitates conversion from the domain entity
  /// to the data model representation.
  factory UserModel.fromUser(User user) {
    return UserModel(
      userId: user.userId,
      nameSurname: user.nameSurname,
      email: user.email,
      photoUrl: user.photoUrl,
      token: user.token,
    );
  }
}

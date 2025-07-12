import "dart:typed_data";

import "package:equatable/equatable.dart";

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class InitAuthStateEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class SignOutEvent extends AuthEvent {}

class UploadProfilePhotoEvent extends AuthEvent {
  final Uint8List bytes;
  final String filename;

  const UploadProfilePhotoEvent({required this.bytes, required this.filename});

  @override
  List<Object> get props => [bytes, filename];
}

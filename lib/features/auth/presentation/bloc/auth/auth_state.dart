import "package:equatable/equatable.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/entities/user.dart";

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

// Authenticated states =================================================

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class UserReloaded extends AuthenticatedState {
  const UserReloaded({required super.user});
}

// Unauthenticated states =================================================

class UnauthenticatedState extends AuthState {}

class SigningIn extends UnauthenticatedState {}

class SigningUp extends UnauthenticatedState {}

class SignInError extends UnauthenticatedState {
  final String message;

  SignInError({required this.message});
}

class SignUpError extends UnauthenticatedState {
  final String message;

  SignUpError({required this.message});
}

// States for navigations =================================================

class NavigateToSignIn extends UnauthenticatedState {}

class NavigateToHome extends AuthenticatedState {
  const NavigateToHome({required super.user});
}

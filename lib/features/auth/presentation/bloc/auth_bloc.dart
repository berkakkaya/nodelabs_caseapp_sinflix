import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/get_current_user_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/is_signed_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_out_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_up_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/upload_profile_photo_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.isSignedInUseCase,
    required this.uploadProfilePhotoUseCase,
  }) : super(AuthInitial()) {
    on<InitAuthStateEvent>(_onInitAuthStatus);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<UploadProfilePhotoEvent>(_onUploadProfilePhoto);
  }

  Future<void> _onInitAuthStatus(
    InitAuthStateEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isSignedIn = await isSignedInUseCase.execute();
      if (isSignedIn) {
        final user = await getCurrentUserUseCase.execute();
        if (user != null) {
          emit(NavigateToHome(user: user));
        } else {
          emit(NavigateToSignIn());
        }
      } else {
        emit(NavigateToSignIn());
      }
    } catch (e) {
      emit(NavigateToSignIn());
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(SigningIn());

    try {
      final user = await signInUseCase.execute(
        email: event.email,
        password: event.password,
      );

      if (user == null) {
        emit(SignInError(message: "Invalid email or password"));
        return;
      }

      emit(NavigateToHome(user: user));
    } catch (e) {
      emit(SignInError(message: e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(SigningUp());

    try {
      final user = await signUpUseCase.execute(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      if (user == null) {
        emit(SignUpError(message: "Email already exists or invalid data"));
        return;
      }

      emit(NavigateToHome(user: user));
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await signOutUseCase.execute();
    emit(NavigateToSignIn());
  }

  Future<void> _onUploadProfilePhoto(
    UploadProfilePhotoEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final newPicUrl = await uploadProfilePhotoUseCase.execute(
        event.bytes,
        filename: event.filename,
      );

      if (newPicUrl != null) {
        emit(ProfilePhotoUploadSuccess(photoUrl: newPicUrl));
        return;
      }

      emit(ProfilePhotoUploadError(message: "Invalid photo upload"));
    } catch (e) {
      emit(ProfilePhotoUploadError(message: e.toString()));
    }
  }
}

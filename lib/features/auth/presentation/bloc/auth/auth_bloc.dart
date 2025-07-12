import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart" show GetIt;
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/get_current_token_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/get_current_user_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/is_signed_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_out_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_up_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/upload_profile_photo_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final GetCurrentTokenUseCase getCurrentTokenUseCase;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.isSignedInUseCase,
    required this.getCurrentTokenUseCase,
    required this.uploadProfilePhotoUseCase,
  }) : super(AuthInitial()) {
    on<InitAuthStateEvent>(_onInitAuthStatus);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<UserDataReloadReqEvent>(_reloadUserData);
  }

  Future<void> _onInitAuthStatus(
    InitAuthStateEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isSignedIn = await isSignedInUseCase.execute();
      if (isSignedIn) {
        final token = await getCurrentTokenUseCase.execute();

        final apiService = GetIt.I.get<RestApiService>();
        apiService.setToken(token);

        if (token == null) {
          emit(NavigateToSignIn());
          return;
        }

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
      rethrow;
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
      rethrow;
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
      rethrow;
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await signOutUseCase.execute();
    emit(NavigateToSignIn());
  }

  Future<void> _reloadUserData(
    UserDataReloadReqEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await getCurrentUserUseCase.execute();

      if (user != null) {
        emit(UserReloaded(user: user));
      } else {
        emit(NavigateToSignIn());
      }
    } catch (e) {
      emit(NavigateToSignIn());
      rethrow;
    }
  }
}

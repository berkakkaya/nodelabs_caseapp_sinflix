import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart" show GetIt;
import "package:nodelabs_caseapp_sinflix/core/consts/theming.dart";
import "package:nodelabs_caseapp_sinflix/core/services/local_storage/i_local_storage_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/logging/i_logging_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/rest_api/i_rest_api_service.dart";
import "package:nodelabs_caseapp_sinflix/core/services/service_locator.dart"
    as service_locator;
import "package:nodelabs_caseapp_sinflix/features/auth/data/datasources/token_data_source.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/data/datasources/user_data_source.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/data/repositories/user_repository_impl.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/get_current_token_usecase.dart"
    show GetCurrentTokenUseCase;
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/get_current_user_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/is_signed_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_in_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_out_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/sign_up_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/upload_profile_photo_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_state.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/views/home_screen.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/views/sign_in_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await service_locator.initializeResources();

  // Get logging service to set up error handlers
  final loggingService = GetIt.instance.get<LoggingService>();

  // Set up Flutter error handler
  FlutterError.onError = (details) {
    loggingService.e("Flutter error", details.exception, details.stack);
  };

  // Set up Platform error handler
  PlatformDispatcher.instance.onError = (error, stack) {
    loggingService.e("Platform error", error, stack);
    return true;
  };

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => _createAuthBloc(context)),
      ],
      child: MaterialApp(
        title: "SinFlix",
        darkTheme: appTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            // Only rebuild when auth state change
            // has been captured that requires a rebuild
            // of the UI.
            return current is AuthInitial ||
                current is NavigateToHome ||
                current is NavigateToSignIn;
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return _initScreen;
            } else if (state is AuthenticatedState) {
              return const HomeScreen(key: Key("home_screen"));
            } else if (state is UnauthenticatedState) {
              return const SignInScreen(key: Key("sign_in_screen"));
            } else {
              // Fallback to sign in screen for any other states
              return const SignInScreen(key: Key("sign_in_screen"));
            }
          },
        ),
      ),
    );
  }

  Widget get _initScreen {
    return const Scaffold(
      body: Center(
        child: SizedBox.square(
          dimension: 100,
          child: CircularProgressIndicator(strokeWidth: 8),
        ),
      ),
    );
  }

  AuthBloc _createAuthBloc(BuildContext context) {
    final getIt = GetIt.instance;
    final storageService = getIt.get<LocalStorageService>();
    final apiService = getIt.get<RestApiService>();
    final loggingService = getIt.get<LoggingService>();

    final authDataSource = UserDataSourceImpl(apiService: apiService);
    final tokenDataSource = TokenDataSourceImpl(storageService: storageService);

    final authRepository = UserRepositoryImpl(
      authDataSource: authDataSource,
      tokenDataSource: tokenDataSource,
    );

    loggingService.d("Creating AuthBloc with dependencies");

    return AuthBloc(
      signInUseCase: SignInUseCase(authRepository),
      signUpUseCase: SignUpUseCase(authRepository),
      signOutUseCase: SignOutUseCase(authRepository),
      getCurrentUserUseCase: GetCurrentUserUseCase(authRepository),
      isSignedInUseCase: IsSignedInUseCase(authRepository),
      getCurrentTokenUseCase: GetCurrentTokenUseCase(authRepository),
      uploadProfilePhotoUseCase: UploadProfilePhotoUseCase(authRepository),
    )..add(InitAuthStateEvent());
  }
}

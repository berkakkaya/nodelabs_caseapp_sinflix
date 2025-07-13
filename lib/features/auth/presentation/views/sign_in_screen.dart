import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/custom_text_field.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/flexible_row_spacer.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_state.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_state.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/widgets/social_media_buttons_group.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/views/sign_up_screen.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(39),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  Text(
                    "Merhabalar",
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  FlexibleRowSpacer(
                    child: Text(
                      "Filmleri kaldığınız yerden keşfetmeye devam edin.",
                      style: textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomTextField(
                    controller: emailController,
                    labelText: "E-posta",
                    prefixIcon: Icon(CustomIcons.messageOutlined),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 13.63),
                  BlocProvider(
                    create: (context) => PwFieldBloc(),
                    child: BlocBuilder<PwFieldBloc, PwFieldState>(
                      builder: (context, state) {
                        return CustomTextField(
                          controller: passwordController,
                          labelText: "Şifre",
                          prefixIcon: Icon(CustomIcons.unlockOutlined),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              final isHidden = state is PwFieldHidden;

                              context.read<PwFieldBloc>().add(
                                isHidden
                                    ? PwFieldShowEvent()
                                    : PwFieldHideEvent(),
                              );
                            },
                            child: Icon(CustomIcons.hideOutlined),
                          ),
                          obscureText: state is PwFieldHidden,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 29.63),
                  Text(
                    "Şifremi unuttum",
                    style: textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: listenAuthStateChanges,
                    listenWhen: (previous, current) {
                      return current is SignInError;
                    },
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: state is! SigningIn
                            ? () => signIn(authBloc)
                            : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            if (state is SigningIn)
                              SizedBox.square(
                                dimension: 12,
                                child: CircularProgressIndicator(),
                              ),
                            Text(
                              state is SigningIn
                                  ? "Giriş yapılıyor..."
                                  : "Giriş Yap",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 36.92),
                  SocialMediaButtonsGroup(
                    onGoogleBtnTapped: () {},
                    onAppleBtnTapped: () {},
                    onFacebookBtnTapped: () {},
                  ),
                  SizedBox(height: 32.27),
                  GestureDetector(
                    onTap: goToSignUpScreen,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hesabın yok mu? ",
                            style: textTheme.bodyMedium?.copyWith(
                              color: kColorWhiteA50,
                            ),
                          ),
                          TextSpan(
                            text: "Kayıt Ol!",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void listenAuthStateChanges(BuildContext context, AuthState state) {
    if (state is SignInError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Oturum açılamadı, lütfen e-posta ve şifrenizi kontrol edin.",
          ),
        ),
      );
    }
  }

  void signIn(AuthBloc authBloc) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lütfen tüm alanları doldurun.")));
      return;
    }

    authBloc.add(
      SignInEvent(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void goToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}

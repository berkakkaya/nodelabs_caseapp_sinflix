import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/custom_text_field.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/flexible_row_spacer.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_bloc.dart"
    show AuthBloc;
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_state.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_state.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/widgets/social_media_buttons_group.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameSurnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameSurnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

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
                    "Hoşgeldiniz",
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  FlexibleRowSpacer(
                    child: Text(
                      "Bir sürü film içeriği ve büyük bir topluluk, burada seni bekliyor.",
                      style: textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomTextField(
                    controller: nameSurnameController,
                    labelText: "Ad soyad",
                    prefixIcon: Icon(CustomIcons.addUserOutlined),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 13.63),
                  CustomTextField(
                    controller: emailController,
                    labelText: "E-posta",
                    prefixIcon: Icon(CustomIcons.messageOutlined),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.63),
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
                  SizedBox(height: 13.63),
                  CustomTextField(
                    controller: confirmPasswordController,
                    labelText: "Şifre Tekrar",
                    prefixIcon: Icon(CustomIcons.unlockOutlined),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.63),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Kullanıcı sözleşmesini ",
                          style: textTheme.bodyMedium?.copyWith(
                            color: kColorWhiteA50,
                          ),
                        ),
                        TextSpan(
                          text: "okudum ve kabul ediyorum.",
                          style: textTheme.bodyMedium?.copyWith(
                            color: textTheme.bodyMedium?.color?.withValues(
                              alpha: 1.0,
                            ),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " Bu sözleşmeyi okuyarak devam ediniz lütfen.",
                          style: textTheme.bodyMedium?.copyWith(
                            color: kColorWhiteA50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 38),
                  BlocConsumer<AuthBloc, AuthState>(
                    listenWhen: (previous, current) {
                      return current is SignUpError;
                    },
                    listener: _handleSignUpEvents,
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: state is! SigningUp
                            ? () => signUp(authBloc)
                            : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            if (state is SigningUp)
                              SizedBox.square(
                                dimension: 12,
                                child: CircularProgressIndicator(),
                              ),
                            Text(
                              state is SigningUp
                                  ? "Kayıt yapılıyor..."
                                  : "Şimdi Kaydol",
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
                    onTap: goBack,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Zaten bir hesabın var mı? ",
                            style: textTheme.bodyMedium?.copyWith(
                              color: kColorWhiteA50,
                            ),
                          ),
                          TextSpan(
                            text: "Giriş Yap!",
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

  void _handleSignUpEvents(BuildContext context, AuthState state) {
    if (state is SignUpError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Kayıt başarısız. Lütfen girdilerinizi ve e-postanızın benzersiz "
            "olup olmadığını kontrol ediniz.",
          ),
        ),
      );
    }
  }

  void signUp(AuthBloc authBloc) {
    final pw = passwordController.text;
    final confirmPw = confirmPasswordController.text;

    if (nameSurnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        pw.isEmpty ||
        confirmPw.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lütfen tüm alanları doldurun.")));
      return;
    }

    if (pw != confirmPw) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Şifreler eşleşmiyor!")));
      return;
    }

    authBloc.add(
      SignUpEvent(
        name: nameSurnameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void goBack() {
    // TODO: Move this to a more appropriate place, like a navigation service.

    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';
import 'package:nodelabs_caseapp_sinflix/core/widgets/custom_text_field.dart';
import 'package:nodelabs_caseapp_sinflix/core/widgets/social_media_buttons_group.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  Row(
                    children: [
                      Spacer(flex: 1),
                      Flexible(
                        flex: 7,
                        child: Text(
                          "Filmleri kaldığınız yerden keşfetmeye devam edin.",
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomTextField(
                    labelText: "E-posta",
                    prefixIcon: Icon(CustomIcons.messageOutlined),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 13.63),
                  CustomTextField(
                    labelText: "Şifre",
                    prefixIcon: Icon(CustomIcons.unlockOutlined),
                    suffixIcon: Icon(CustomIcons.hideOutlined),
                    obscureText: true,
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
                  FilledButton(onPressed: () {}, child: Text("Giriş Yap")),
                  SizedBox(height: 36.92),
                  SocialMediaButtonsGroup(),
                  SizedBox(height: 32.27),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hesabın yok mu? ",
                            style: textTheme.bodyMedium?.copyWith(
                              color: textTheme.bodyMedium?.color?.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "Kayıt Ol!",
                            style: textTheme.bodyMedium?.copyWith(
                              color: textTheme.bodyMedium?.color?.withValues(
                                alpha: 1.0,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
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
}

import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';
import 'package:nodelabs_caseapp_sinflix/core/widgets/custom_text_field.dart';
import 'package:nodelabs_caseapp_sinflix/core/widgets/social_media_buttons_group.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    "Hoşgeldiniz",
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
                          "Bir sürü film içeriği ve büyük bir topluluk, burada seni bekliyor.",
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomTextField(
                    labelText: "Ad soyad",
                    prefixIcon: Icon(CustomIcons.addUserOutlined),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 13.63),
                  CustomTextField(
                    labelText: "E-posta",
                    prefixIcon: Icon(CustomIcons.messageOutlined),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.63),
                  CustomTextField(
                    labelText: "Şifre",
                    prefixIcon: Icon(CustomIcons.unlockOutlined),
                    suffixIcon: Icon(CustomIcons.hideOutlined),
                    obscureText: true,
                  ),
                  SizedBox(height: 13.63),
                  CustomTextField(
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
                  FilledButton(onPressed: () {}, child: Text("Şimdi Kaydol")),
                  SizedBox(height: 36.92),
                  SocialMediaButtonsGroup(),
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

  void goBack() {
    // TODO: Move this to a more appropriate place, like a navigation service.

    Navigator.of(context).pop();
  }
}

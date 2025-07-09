import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';

class SocialMediaButtonsGroup extends StatelessWidget {
  final VoidCallback? onGoogleBtnTapped;
  final VoidCallback? onAppleBtnTapped;
  final VoidCallback? onFacebookBtnTapped;

  const SocialMediaButtonsGroup({
    super.key,
    this.onGoogleBtnTapped,
    this.onAppleBtnTapped,
    this.onFacebookBtnTapped,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = 24;
    final Color iconColor = kColorWhite;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.44,
      children: [
        _ButtonContainer(
          onTap: onGoogleBtnTapped,
          child: Icon(CustomIcons.logoGoogle, color: iconColor, size: iconSize),
        ),
        _ButtonContainer(
          onTap: onAppleBtnTapped,
          child: Icon(CustomIcons.logoApple, color: iconColor, size: iconSize),
        ),
        _ButtonContainer(
          onTap: onFacebookBtnTapped,
          child: Icon(
            CustomIcons.logoFacebook,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ],
    );
  }
}

class _ButtonContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _ButtonContainer({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kColorWhiteA10,
            borderRadius: borderRadius,
            border: Border.all(
              color: kColorWhiteA20,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

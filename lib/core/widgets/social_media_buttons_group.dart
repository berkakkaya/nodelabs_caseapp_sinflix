import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';

/// A widget that displays a horizontal group of social media login buttons.
///
/// This widget provides a pre-configured set of social media authentication
/// buttons including Google, Apple, and Facebook. Each button is styled
/// consistently with rounded corners, semi-transparent backgrounds, and
/// proper spacing between elements.
///
/// The widget features:
/// - Three social media buttons: Google, Apple, and Facebook
/// - Consistent styling with custom icons and colors
/// - Optional callback functions for each button
/// - Material design ripple effects on tap
/// - Responsive layout with proper spacing
/// - Disabled state handling when callbacks are null
class SocialMediaButtonsGroup extends StatelessWidget {
  /// Callback function triggered when the Google sign-in button is tapped.
  ///
  /// If null, the Google button will be displayed but non-interactive.
  final VoidCallback? onGoogleBtnTapped;

  /// Callback function triggered when the Apple sign-in button is tapped.
  ///
  /// If null, the Apple button will be displayed but non-interactive.
  final VoidCallback? onAppleBtnTapped;

  /// Callback function triggered when the Facebook sign-in button is tapped.
  ///
  /// If null, the Facebook button will be displayed but non-interactive.
  final VoidCallback? onFacebookBtnTapped;

  /// Creates a social media buttons group with optional callback functions.
  ///
  /// All callback parameters are optional. If a callback is null, the
  /// corresponding button will be displayed but will not respond to taps.
  /// This allows for flexible implementation where not all social media
  /// providers need to be supported.
  const SocialMediaButtonsGroup({
    super.key,
    this.onGoogleBtnTapped,
    this.onAppleBtnTapped,
    this.onFacebookBtnTapped,
  });

  /// Builds the social media buttons group widget.
  ///
  /// Creates a horizontal [Row] containing three social media buttons
  /// (Google, Apple, Facebook) with consistent spacing and styling.
  ///
  /// The buttons are centered in the available space with 8.44px spacing
  /// between each button. All icons are sized at 24px and colored white.
  @override
  Widget build(BuildContext context) {
    // Constants for consistent button styling
    final double iconSize = 24;
    final Color iconColor = kColorWhite;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.44,
      children: [
        // Google sign-in button
        _ButtonContainer(
          onTap: onGoogleBtnTapped,
          child: Icon(CustomIcons.logoGoogle, color: iconColor, size: iconSize),
        ),
        // Apple sign-in button
        _ButtonContainer(
          onTap: onAppleBtnTapped,
          child: Icon(CustomIcons.logoApple, color: iconColor, size: iconSize),
        ),
        // Facebook sign-in button
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

/// A private helper widget that provides a consistent container style for
/// social media buttons.
///
/// This widget creates a rounded, semi-transparent container with a border
/// that responds to user taps with Material Design ripple effects. It's used
/// internally by [SocialMediaButtonsGroup] to ensure all social media buttons
/// have identical styling and behavior.
class _ButtonContainer extends StatelessWidget {
  /// The widget to display inside the button container.
  ///
  /// Typically an [Icon] widget representing a social media platform.
  final Widget child;

  /// Callback function triggered when the button is tapped.
  ///
  /// If null, the button will be displayed but non-interactive.
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

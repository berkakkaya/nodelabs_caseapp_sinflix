import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

/// A widget for displaying and selecting profile photos with a consistent
/// circular design.
///
/// This widget provides a square container with rounded corners that maintains
/// a 1:1 aspect ratio, making it perfect for profile photo selection
/// interfaces. It features Material Design touch feedback and can display
/// either a placeholder icon (like a plus sign) or an actual profile image.
///
/// The widget features:
/// - 1:1 aspect ratio container for consistent sizing
/// - Rounded corners with 31px border radius
/// - Semi-transparent background with subtle border
/// - Material Design ripple effects on tap
/// - 40px padding for comfortable touch targets
/// - Flexible content support via child widget
/// - Optional tap callback for interaction
/// ```
class AddProfilePhotoWidget extends StatelessWidget {
  /// The widget to display inside the profile photo container.
  ///
  /// This can be any widget such as an icon (for placeholder state),
  /// an image widget (for actual photos), or a [CircleAvatar]. The child
  /// will be centered within the container with 40px padding on all sides.
  final Widget child;

  /// Callback function triggered when the widget is tapped.
  ///
  /// If null, the widget will be displayed but non-interactive (no ripple
  /// effects or tap handling). Typically used for photo selection, editing,
  /// or viewing actions.
  final void Function()? onTap;

  const AddProfilePhotoWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 31;

    return AspectRatio(
      aspectRatio: 1, // Maintains square aspect ratio
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: kColorWhiteA10,
              borderRadius: BorderRadius.circular(borderRadiusValue),
              border: Border.all(
                color: kColorWhiteA10,
                width: 1.55,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

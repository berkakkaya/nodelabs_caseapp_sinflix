import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";

/// A custom app bar widget with automatic back button and flexible layout.
///
/// This widget provides a clean, customizable app bar that automatically shows
/// a back button when the current route can be popped, centers the title,
/// and optionally displays a suffix widget on the right side.
///
/// The widget features:
/// - Automatic back button detection and display
/// - Centered title with consistent text styling
/// - Optional suffix widget for additional actions
/// - Stack-based layout for proper positioning
/// - Custom back arrow icon integration
/// - Responsive design that adapts to navigation state
class CustomAppbar extends StatelessWidget {
  /// The title widget displayed in the center of the app bar.
  ///
  /// This widget will be styled with the theme's [TextTheme.titleMedium] style
  /// automatically via [DefaultTextStyle]. Typically a [Text] widget.
  final Widget title;

  /// Optional widget displayed on the right side of the app bar.
  ///
  /// Commonly used for action buttons, menu triggers, or other interactive
  /// elements. Will only be displayed if not null.
  final Widget? suffix;

  const CustomAppbar({super.key, required this.title, this.suffix});

  @override
  Widget build(BuildContext context) {
    // Check if the current route can be popped (has a previous route)
    final canPop = Navigator.canPop(context);
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Back button - only shown if navigation can pop
        if (canPop)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(CustomIcons.arrowBack),
            ),
          ),
        Align(
          alignment: Alignment.center,
          child: DefaultTextStyle(style: textTheme.titleMedium!, child: title),
        ),
        if (suffix != null)
          Align(alignment: Alignment.centerRight, child: suffix),
      ],
    );
  }
}

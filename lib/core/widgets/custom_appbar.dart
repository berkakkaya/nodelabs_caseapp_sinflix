import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";

/// A custom app bar widget with automatic back button and flexible layout.
///
/// This widget provides a clean, customizable app bar that automatically shows
/// a back button when the current route can be popped, centers the title,
/// and optionally displays a suffix widget on the right side.
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

  /// Flex values for the left and right side of the app bar.
  final int sideFlexes;

  /// Flex value for the middle section of the app bar, which contains the
  /// title.
  final int middleFlex;

  const CustomAppbar({
    super.key,
    required this.title,
    this.suffix,
    this.sideFlexes = 2,
    this.middleFlex = 3,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the current route can be popped (has a previous route)
    final canPop = Navigator.canPop(context);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        Expanded(
          flex: sideFlexes,
          child: canPop
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: Icon(CustomIcons.arrowBack),
                  ),
                )
              : SizedBox.shrink(),
        ),
        Expanded(
          flex: middleFlex,
          child: DefaultTextStyle(
            style: textTheme.titleMedium!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            child: title,
          ),
        ),
        Expanded(
          flex: sideFlexes,
          child: Align(
            alignment: Alignment.centerRight,
            child: suffix ?? SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/views/widgets/tab_chip.dart";

/// A custom bottom navigation bar widget that displays a row of tabs.
///
/// The [CustomBottomNavbar] takes a list of [Widget]s as [items] and arranges
/// them horizontally with custom padding and background color. The navigation
/// bar is styled with a black background and symmetric horizontal and
/// vertical padding.
///
/// The [items] parameter should contain the widgets to be displayed in the
/// navigation bar. These widgets will be typically [TabChip] widgets.
class CustomBottomNavbar extends StatelessWidget {
  /// The list of widgets to be displayed in the bottom navigation bar,
  /// typically [TabChip] widgets.
  final List<Widget> items;

  const CustomBottomNavbar({super.key, required this.items})
    : assert(items.length != 0, "Items list must not be empty");

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: kColorBlack),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 13.72,
          bottom: 16.47,
          left: 16.0,
          right: 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: items,
        ),
      ),
    );
  }
}

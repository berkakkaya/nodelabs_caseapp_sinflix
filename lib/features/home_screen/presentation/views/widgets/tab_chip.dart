import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

/// A custom chip widget that displays an icon and a label inside a
/// stadium-shaped border.
///
/// The [TabChip] is a stateless widget designed to be used as a tab indicator,
/// featuring a customizable [icon] and [label]. The chip uses a stadium border
/// with a semi-transparent white outline and applies consistent padding and
/// styling to its contents.
class TabChip extends StatelessWidget {
  /// The label text displayed inside the chip.
  final String label;

  /// The icon displayed inside the chip. Preferably an [Icon] widget.
  final Widget icon;

  /// Callback function that is triggered when the chip is tapped.
  final void Function() onTap;

  const TabChip({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Material(
      color: Colors.transparent,
      shape: const StadiumBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        splashColor: kColorWhiteA20,
        child: Container(
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: kColorWhiteA20,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.4,
              vertical: 6.46,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                  data: theme.iconTheme.copyWith(color: kColorWhite, size: 28),
                  child: icon,
                ),
                SizedBox(width: 8.23),
                Text(label, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

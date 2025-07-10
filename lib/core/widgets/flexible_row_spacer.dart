import 'package:flutter/material.dart';

/// A reusable widget that creates a row with flexible spacers on the sides
/// and a centered child widget.
///
/// This widget is commonly used to center content with flexible spacing
/// on both sides, maintaining a responsive layout.
class FlexibleRowSpacer extends StatelessWidget {
  /// The widget to be displayed in the center
  final Widget child;

  /// The flex value for the spacers on both sides (default: 1)
  final int spacerFlex;

  /// The flex value for the center child (default: 7)
  final int childFlex;

  const FlexibleRowSpacer({
    super.key,
    required this.child,
    this.spacerFlex = 1,
    this.childFlex = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(flex: spacerFlex),
        Flexible(flex: childFlex, child: child),
        Spacer(flex: spacerFlex),
      ],
    );
  }
}

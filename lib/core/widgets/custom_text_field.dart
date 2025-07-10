import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';

/// A custom text field widget with a modern design and flexible configuration.
///
/// This widget provides a styled text input field with rounded corners,
/// custom colors, and support for prefix/suffix icons. It's designed to
/// maintain consistency across the application's form inputs.
class CustomTextField extends StatefulWidget {
  /// The placeholder text displayed when the field is empty
  final String labelText;

  /// Optional icon widget displayed at the beginning of the text field
  final Widget? prefixIcon;

  /// Optional icon widget displayed at the end of the text field
  final Widget? suffixIcon;

  /// Controller for managing the text field's content
  final TextEditingController? controller;

  /// Focus node for managing focus state. If not provided, one will be created automatically
  final FocusNode? focusNode;

  /// Whether to obscure the text (useful for passwords). Defaults to false
  final bool obscureText;

  /// Validation function that returns an error message or null if valid
  final String? Function(String?)? validator;

  /// The type of keyboard to display for this text field
  final TextInputType? keyboardType;

  /// Callback function called when the text field value changes
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// The focus node used by this text field. Either provided by the widget
  /// or created internally if none is provided.
  FocusNode? _usedFocusNode;

  /// Returns true if the focus node is provided externally,
  /// false if it was created internally.
  bool get _isFocusNodeExternal => widget.focusNode != null;

  @override
  void initState() {
    super.initState();
    _usedFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (!_isFocusNodeExternal) {
      // Only dispose the focus node if it was created internally
      _usedFocusNode?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final iconThemeData = theme.iconTheme.copyWith(
      size: 17,
      color: kColorWhite,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _usedFocusNode?.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 19.18,
          left: 24,
          bottom: 16.19,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: kColorWhiteA10,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: kColorWhiteA20,
            width: 1,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              IconTheme(data: iconThemeData, child: widget.prefixIcon!),
              const SizedBox(width: 9.33),
            ],
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                focusNode: _usedFocusNode,
                obscureText: widget.obscureText,
                validator: widget.validator,
                keyboardType: widget.keyboardType,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  hintText: widget.labelText,
                  hintStyle: textTheme.bodyMedium?.copyWith(
                    color: kColorWhiteA50,
                  ),
                ),
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              const SizedBox(width: 9.33),
              IconTheme(data: iconThemeData, child: widget.suffixIcon!),
            ],
          ],
        ),
      ),
    );
  }
}

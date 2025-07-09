import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
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
  FocusNode? _usedFocusNode;

  @override
  void initState() {
    super.initState();
    _usedFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _usedFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              Icon(widget.prefixIcon, color: kColorWhite),
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
          ],
        ),
      ),
    );
  }
}

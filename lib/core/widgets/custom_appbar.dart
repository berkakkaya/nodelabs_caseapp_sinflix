import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';

class CustomAppbar extends StatelessWidget {
  final Widget title;
  final Widget? suffix;

  const CustomAppbar({super.key, required this.title, this.suffix});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
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

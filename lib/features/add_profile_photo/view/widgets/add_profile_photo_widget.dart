import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/colors.dart';

class AddProfilePhotoWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;

  const AddProfilePhotoWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 31;

    return AspectRatio(
      aspectRatio: 1,
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

import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

class ProfileDetailsWidget extends StatelessWidget {
  final ImageProvider? profileImgProvider;
  final String nameSurname;
  final String userId;
  final void Function() onProfileImgChangeClicked;

  const ProfileDetailsWidget({
    super.key,
    this.profileImgProvider,
    required this.nameSurname,
    required this.userId,
    required this.onProfileImgChangeClicked,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 9.05,
      children: [
        CircleAvatar(
          foregroundImage: profileImgProvider,
          backgroundColor: kColorWhiteA20,
          maxRadius: 30.95,
          minRadius: 30.95,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.78,
            children: [
              Text(
                nameSurname,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: kColorWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "ID: $userId",
                style: textTheme.bodyMedium?.copyWith(color: kColorWhiteA50),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        FilledButton(
          style: theme.filledButtonTheme.style?.copyWith(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 19, vertical: 10),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          onPressed: () {},
          child: Text("Fotoğraf Ekle"),
        ),
      ],
    );
  }
}

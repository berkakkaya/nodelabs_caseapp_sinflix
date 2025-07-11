import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";

class LikedMovieWidget extends StatelessWidget {
  final ImageProvider posterImgProvider;
  final String title;
  final String description;

  const LikedMovieWidget({
    super.key,
    required this.posterImgProvider,
    required this.title,
    this.description = "Açıklama yok.",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 153.13 / 213.82,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: posterImgProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: kColorWhiteA50),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

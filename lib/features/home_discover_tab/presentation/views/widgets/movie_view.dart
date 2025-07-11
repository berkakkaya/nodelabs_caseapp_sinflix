
import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";

class MovieView extends StatelessWidget {
  final ImageProvider imgProvider;
  final String title;
  final String description;

  const MovieView({
    super.key,
    required this.imgProvider,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: imgProvider,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: Colors.black12),
                    if (frame == null)
                      const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    AnimatedOpacity(
                      opacity: frame != null ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: child,
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 69.91,
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: kColorBlackGradientTTB),
            ),
          ),
          Positioned(
            bottom: 26.11,
            left: 0,
            right: 0,
            child: _MovieDescriptionWidget(
              title: title,
              description: description,
            ),
          ),
          Positioned(
            bottom: 100.2,
            right: 16.49,
            width: 49.18,
            height: 71.17,
            child: _LikeButton(),
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorBlack.withValues(alpha: 0.60),
      shape: StadiumBorder(
        side: BorderSide(
          color: kColorWhiteA20,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(35.585),
        onTap: () {
          // TODO: Implement like button tap
        },
        child: Center(child: Icon(CustomIcons.like, size: 24)),
      ),
    );
  }
}

class _MovieDescriptionWidget extends StatelessWidget {
  const _MovieDescriptionWidget({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15.94,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kColorBrand,
              shape: BoxShape.circle,
              border: Border.all(
                color: kColorWhite,
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.play_arrow_rounded,
                color: kColorWhite,
                size: 21,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 0.78),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: kColorWhiteA75),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

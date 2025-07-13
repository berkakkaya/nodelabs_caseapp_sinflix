import "package:flutter/material.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";

class MovieView extends StatefulWidget {
  final ImageProvider imgProvider;
  final String title;
  final String description;
  final bool isLiked;
  final void Function()? onLikeToggle;

  const MovieView({
    super.key,
    required this.imgProvider,
    required this.title,
    required this.description,
    this.isLiked = false,
    this.onLikeToggle,
  });

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
  }

  @override
  void didUpdateWidget(MovieView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local state if prop changes from parent
    if (oldWidget.isLiked != widget.isLiked) {
      _isLiked = widget.isLiked;
    }
  }

  void _handleLikeToggle() {
    // Update local state immediately for responsive UI
    setState(() {
      _isLiked = !_isLiked;
    });

    // Notify parent about the change
    if (widget.onLikeToggle != null) {
      widget.onLikeToggle!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: widget.imgProvider,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: kColorBlack,
                  child: const Center(
                    child: Icon(Icons.error, color: kColorWhite, size: 48),
                  ),
                );
              },
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
              title: widget.title,
              description: widget.description,
            ),
          ),
          Positioned(
            bottom: 100.2,
            right: 16.49,
            width: 49.18,
            height: 71.17,
            child: _LikeButton(isLiked: _isLiked, onTap: _handleLikeToggle),
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap;

  const _LikeButton({required this.isLiked, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isLiked
          ? Colors.pink.withValues(alpha: 0.60)
          : kColorBlack.withValues(alpha: 0.60),
      shape: StadiumBorder(
        side: BorderSide(
          color: kColorWhiteA20,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(35.585),
        onTap: onTap,
        splashColor: isLiked
            ? Colors.pink.withAlpha(100)
            : kColorWhite.withAlpha(100),
        highlightColor: isLiked
            ? Colors.pink.withAlpha(70)
            : kColorWhite.withAlpha(70),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              CustomIcons.like,
              key: ValueKey<bool>(isLiked),
              size: 24,
              color: isLiked
                  ? Colors.white
                  : kColorWhite.withValues(alpha: 0.80),
            ),
          ),
        ),
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

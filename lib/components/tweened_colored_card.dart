import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TweenedColoredCard extends HookConsumerWidget {
  final Widget child;
  final Duration duration;
  final Color startColor;
  final Color endColor;
  final Curve curve;

  /// The animation of color begins the instant shouldPlay == [true]
  final ValueNotifier<bool> shouldPlay;
  const TweenedColoredCard({
    super.key,
    required this.duration,
    required this.child,
    required this.startColor,
    required this.endColor,
    this.curve = Curves.linear,
    required this.shouldPlay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: shouldPlay,
      child: child,
      builder: (context, shouldTransitionColor, child) {
        if (shouldTransitionColor) {
          return TweenAnimationBuilder(
            tween: ColorTween(
              begin: startColor,
              end: endColor,
            ),
            curve: curve,
            duration: duration,
            builder: (context, value, child) {
              return Card(
                color: value,
                child: this.child,
              );
            },
          );
        } else {
          return Card(
            color: startColor,
            child: this.child,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_timers/components/todays_metrics.dart';
import 'package:habit_timers/data/habit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_timers/definitions.dart';
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

class HabitCard extends HookConsumerWidget {
  final Habit data;
  const HabitCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = useState(false);

    return TweenedColoredCard(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      startColor: context.colorScheme.background,
      endColor: Colors.blue,
      shouldPlay: isActive,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        data.title,
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(data.description,
                          style: context.textTheme.bodyMedium)
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isActive.value = !isActive.value;
                    },
                    child: Text(isActive.value ? "Stop timer" : "Start timer"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              TodaysMetrics(
                  seconds: data.secondsClockedIn,
                  targetSeconds: data.targetSecondsClockedIn),
            ],
          ),
        ),
      ),
    );
  }
}

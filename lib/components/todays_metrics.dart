import 'package:flutter/material.dart';
import 'package:habit_timers/definitions.dart';

class TodaysMetrics extends StatelessWidget {
  final Color? backgroundColor;
  final Seconds seconds;
  final Seconds targetSeconds;

  /// How to display.
  final TimeUnits units;
  const TodaysMetrics({
    super.key,
    required this.seconds,
    required this.targetSeconds,
    this.units = TimeUnits.minute,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var timeDone = switch (units) {
      TimeUnits.hour => seconds / 3600,
      TimeUnits.minute => seconds / 60,
    };
    var timeTarget = switch (units) {
      TimeUnits.hour => targetSeconds / 3600,
      TimeUnits.minute => targetSeconds / 60,
    };

    final typography = Theme.of(context).textTheme;
    var dividingLine = ColoredBox(
      color: context.colorScheme.primary,
      child: const SizedBox(
        height: 200,
        width: 4,
      ),
    );

    final percentageString = "${(seconds / targetSeconds).toStringAsFixed(0)}%";
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Done",
                style: typography.labelLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "${timeDone.toStringAsFixed(0)}\n${units.name}s",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          dividingLine,
          Column(
            children: [
              Text(
                "Goal",
                style: typography.labelLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "${timeTarget.toStringAsFixed(0)}\n${units.name}s",
                textAlign: TextAlign.center,
              )
            ],
          ),
          dividingLine,
          Column(
            children: [
              Text(
                "Progress",
                style: typography.labelLarge,
              ),
              const SizedBox(height: 16),
              Stack(alignment: Alignment.center, children: [
                Text(
                  percentageString,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelSmall,
                ),
                CircularProgressIndicator(
                  semanticsLabel: "Progress in habit.",
                  semanticsValue: percentageString,
                  value: seconds / targetSeconds,
                  backgroundColor: Colors.green,
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}

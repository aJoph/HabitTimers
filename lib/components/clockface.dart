import 'package:flutter/material.dart';
import 'package:habit_timers/definitions.dart';

class Clockface extends StatelessWidget {
  const Clockface({
    super.key,
    required this.clockSize,
  });

  final double clockSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: clockSize + (clockSize / 4),
      height: clockSize + (clockSize / 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "25:00",
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall,
          ),
          // Below
          SizedBox(
            width: clockSize,
            height: clockSize,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: clockSize / 12,
              color: context.colorScheme.tertiary,
            ),
          ),
          // Ontop
          SizedBox(
            width: clockSize,
            height: clockSize,
            child: CircularProgressIndicator(
              value: 0.2,
              strokeWidth: clockSize / 12,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_timers/components/todays_metrics.dart';
import 'package:habit_timers/data/habit.dart';
import 'package:habit_timers/definitions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/habit_timer_page.dart';

class HabitCard extends HookConsumerWidget {
  final Habit data;
  const HabitCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
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
                      Text(
                        data.description,
                        style: context.textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => onPressedOpen(context),
                    child: const Text("Open"),
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

  void onPressedOpen(BuildContext context) {
    context.navigator.push<void>(MaterialPageRoute(
      builder: (context) {
        return HabitTimerPage(data);
      },
    ));
  }
}

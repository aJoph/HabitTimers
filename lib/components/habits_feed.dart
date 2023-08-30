import 'package:flutter/material.dart';
import 'package:habit_timers/definitions.dart';
import 'package:habit_timers/providers/habits_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'habit_card.dart';

class HabitsFeed extends HookConsumerWidget {
  final Color? backgroundColor;
  const HabitsFeed({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);

    if (habits.isEmpty) {
      return Container(
        width: double.infinity,
        color: context.colorScheme.errorContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No habits to display!",
              style: context.textTheme.displaySmall,
            ),
            Text("Add one below", style: context.textTheme.bodyLarge)
          ],
        ),
      );
    }

    return Material(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, i) {
          return HabitCard(data: habits[i]);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_timers/data/habit.dart';
import 'package:habit_timers/pages/habits_page.dart';
import 'package:habit_timers/providers/habits_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddHabitButton extends HookConsumerWidget {
  const AddHabitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      height: 200,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddHabitDialog();
              }).then((value) => switch (
                  value) {
                Habit toAdd =>
                  ref.read(habitsProvider.notifier).addHabit(toAdd),
                _ => null
              });
        },
        style: const ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
        child: const Text("+"),
      ),
    );
  }
}

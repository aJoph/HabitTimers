import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_timers/components/clockface.dart';
import 'package:habit_timers/components/twin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/habit.dart';

class HabitTimerPage extends HookConsumerWidget {
  final Habit habit;
  const HabitTimerPage(this.habit, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTicking = useState(false);

    const clockSize = 200.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const Clockface(clockSize: clockSize),
            isTicking.value
                ? TwinButton(
                    childOne: const Text("Pause"),
                    childTwo: const Text("Stop"),
                    onPressed1st: () {
                      isTicking.value = false;
                    },
                    onPressed2nd: () {},
                  )
                : SizedBox(
                    width: 200,
                    height: 100 * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        isTicking.value = true;
                      },
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                        ),
                      ),
                      child: const Text("Start"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

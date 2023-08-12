import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_timers/components/habit_card.dart';
import 'package:habit_timers/components/todays_metrics.dart';
import 'package:habit_timers/data/habit.dart';
import 'package:habit_timers/definitions.dart';
import 'package:habit_timers/providers/habits_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HabitsPage extends HookConsumerWidget {
  const HabitsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Material(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(36.0),
            bottomRight: Radius.circular(36.0),
          ),
          color: context.colorScheme.primaryContainer,
          child: Column(
            children: [
              Text(
                "Today's Total",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TodaysMetrics(
                seconds: 20 * 60,
                targetSeconds: 60 * 60,
                backgroundColor: context.colorScheme.primaryContainer,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Habits",
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const SizedBox(
          height: 200,
          child: HabitsFeed(),
        ),
        const SizedBox(height: 8),
        const AddHabitButton(),
      ],
    );
  }
}

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

class DefaultPlaceholders {
  static const titleDescriptionPairs = {
    "Practice guitar": "Just practice chords!",
    "Practice skateboarding": "Do a few tricks!",
    "Go on a walk": "The neighborhood is so nice!"
  };

  static (String, String) get placeholders {
    final entry = titleDescriptionPairs.entries
        .elementAt(Random().nextInt(titleDescriptionPairs.length));

    return (
      entry.key,
      entry.value,
    );
  }

  static int get minutesPlaceholder => Random().nextInt(90);
}

class AddHabitDialog extends HookConsumerWidget {
  AddHabitDialog({
    super.key,
  });

  final formKey = GlobalKey<FormState>();
  final placeholderHintText = DefaultPlaceholders.placeholders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final targetController = useTextEditingController();

    return AlertDialog(
        actions: [
          TextButton(
            onPressed: () => context.navigator.pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              debugPrint("Attempting to validate add habit form");
              if (formKey.currentState == null) return;
              if (formKey.currentState!.validate()) {
                debugPrint("add habit form validated as true.");
                context.navigator.pop(Habit(
                  titleController.text,
                  descriptionController.text,
                  0,
                  double.tryParse(targetController.text) ?? 0,
                ));
              } else {
                debugPrint("add habit form validated as false.");
              }
            },
            child: const Text("Confirm"),
          )
        ],
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please input a title!";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Title"),
                    hintText: placeholderHintText.$1,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please input a description!";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Description"),
                    hintText: placeholderHintText.$2,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: targetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please input a target minute amount!";
                    }

                    final numericalValue = double.tryParse(value);
                    if (numericalValue == null) return "Please input a number!";
                    if (numericalValue < 0) {
                      targetController.clear();
                      return "Please input a positive number!";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Target minutes"),
                    hintText: DefaultPlaceholders.minutesPlaceholder.toString(),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ],
          ),
        ));
  }
}

class HabitsFeed extends HookConsumerWidget {
  const HabitsFeed({
    super.key,
  });

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

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, i) {
        return HabitCard(data: habits[i]);
      },
    );
  }
}

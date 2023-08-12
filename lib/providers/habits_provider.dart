import 'package:habit_timers/data/habit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HabitsRepository {
  const HabitsRepository();
  void add(Habit toAdd) {}
  void remove(Habit toRemove) {}
  void update(Habit toUpdate) {}
  void clear() {}
}

class SqlHabitsRepository extends HabitsRepository {
  const SqlHabitsRepository();
}

class WebHabitsRepository extends HabitsRepository {}

class OnlineHabitsRepository extends HabitsRepository {}

var habitsProvider = StateNotifierProvider<HabitsNotifier, List<Habit>>(
  (ref) => HabitsNotifier([]),
);

class HabitsNotifier extends StateNotifier<List<Habit>> {
  final HabitsRepository repository;

  HabitsNotifier(
    super.initialState, {
    this.repository = const SqlHabitsRepository(),
  });

  void addHabit(Habit toAdd) {
    repository.add(toAdd);
    state = [...state, toAdd];
  }

  void removeHabit(Habit toRemove) {
    repository.remove(toRemove);
    state = [
      for (var habit in state)
        if (habit != toRemove) habit
    ];
  }

  void updateHabit(Habit toUpdate) {
    repository.update(toUpdate);
  }

  void clearHabits() {
    state.clear();
    repository.clear();
  }
}

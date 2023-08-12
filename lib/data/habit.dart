import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Habit {
  final String title;
  final String description;
  final double secondsClockedIn;
  final double targetSecondsClockedIn;

  const Habit(this.title, this.description, this.secondsClockedIn,
      this.targetSecondsClockedIn)
      : assert(secondsClockedIn >= 0, "secondsClockedIn must be positive"),
        assert(targetSecondsClockedIn >= 0,
            "targetSecondsClockedIn must be positive");

  double get percentageClockedIn => secondsClockedIn / targetSecondsClockedIn;
  String get percentageClockedInString => "${percentageClockedIn.toInt()}" "%";
}

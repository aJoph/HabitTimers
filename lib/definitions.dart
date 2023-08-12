// Definitions for miscellaneous type definitions that don't deserve their own dedicated file.

import 'package:flutter/material.dart';

typedef Seconds = double;

Seconds secondsToMinute(Seconds seconds) {
  return seconds / 60;
}

Seconds secondsToHour(Seconds seconds) {
  return seconds / 3600;
}

enum TimeUnits {
  hour,
  minute,
}

extension ContextGoodies on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  NavigatorState get navigator => Navigator.of(this);
}

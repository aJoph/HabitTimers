import 'package:flutter/material.dart';
import 'package:habit_timers/definitions.dart';
import 'package:habit_timers/pages/habits_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habits",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Habits"),
          centerTitle: true,
          backgroundColor: context.colorScheme.surfaceTint,
        ),
        body: const SafeArea(
          child: HabitsPage(),
        ),
      ),
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:random_starter/common/dependency_injector.dart';
import 'package:random_starter/presentation/fortune_wheel_page.dart';

void main() {
  injectorSetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const FortuneWheelPage(),
    );
  }
}

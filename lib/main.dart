import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

void main() async {
  final isar = await Isar.open([TripModelSchema]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti-forgetter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SkeletonScreen(),
    );
  }
}

import 'package:anti_forgetter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
    );
  }

  @override
  void dispose() {
    // closes all opened boxes to avoid memory leaks
    Hive.close();
    super.dispose();
  }
}

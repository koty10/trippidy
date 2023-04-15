import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/trips_controller.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';

// Maybe remove loading screen and load data directly on homepage
class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(tripsControllerProvider).when(
      data: (data) {
        return const SkeletonScreen();
      },
      error: (err, stack) {
        return const Center(
          child: Text('error'),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

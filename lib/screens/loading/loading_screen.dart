import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/trips_provider.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder<void>(
      future: init(ref),
      builder: (context, AsyncSnapshot<void> snapshot) {
        // TODO: Consider checking for errors and displaying an error screen
        if (snapshot.connectionState == ConnectionState.done) {
          return const SkeletonScreen(); // snapshot.data!;
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Načítání'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<void> init(WidgetRef ref) async {
    ref.read(tripsProvider.notifier).initFromFirebase();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/trips_provider.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';

// Maybe remove loading screen and load data directly on homepage
class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(tripsProvider.notifier).initFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(tripsProvider).when(
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

  Future<void> init(WidgetRef ref) async {
    // AsyncValue result = await ref.read(tripsProvider.notifier).initFromFirebase();

    // result.when(
    //   data: (data) {
    //     //ref.watch(provider).data;
    //     //return MyUiForData(data);
    //   },
    //   error: (err, stack) {
    //     return Row(
    //       children: [
    //         Text('Error: $err'),
    //         TextButton(
    //           onPressed: () {
    //             // opravny api call
    //           },
    //           child: const Text('Zkusit znovu'),
    //         ),
    //       ],
    //     );
    //   },
    //   loading: () {
    //     return const Center(child: CircularProgressIndicator());
    //   },
    // );
  }
}

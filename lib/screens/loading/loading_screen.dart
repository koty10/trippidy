import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/trips_provider.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';

import '../../model/user.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder<Widget>(
      future: init(ref),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data!);
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Loading View'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Future<Widget> init(WidgetRef ref) async {
    final userGoogle = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userGoogle.uid)
        .set(
          User(
            documentId: userGoogle.uid,
            name: userGoogle.displayName ?? userGoogle.uid,
          ).toMap(),
        );
    ref.read(tripsProvider.notifier).initFromFirebase();
    return const SkeletonScreen();
  }
}

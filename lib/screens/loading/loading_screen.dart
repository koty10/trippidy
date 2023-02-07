import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:trippidy/providers/trips_provider.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';

import '../../model/user.dart';

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
    // save user to db only when the app is used first time
    if (Hive.box("user").get("id") == null) {
      final userGoogle = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance.collection('users').doc(userGoogle.uid).set(
            User(
              documentId: userGoogle.uid,
              name: userGoogle.displayName ?? userGoogle.uid,
            ).toMap(),
          );
    }
    ref.read(tripsProvider.notifier).initFromFirebase();
  }
}

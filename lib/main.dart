import 'package:firebase_core/firebase_core.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // var db = FirebaseFirestore.instance;

  // var user1 = UserDto(id: "1", name: "Daniel", trips: []);

  // var trip1 = TripDto(id: "1", name: "Dansko", members: [
  //   MemberDto(
  //       id: "1",
  //       user: user1.id,
  //       items: [
  //         Item(
  //             id: "1",
  //             category: Category(id: "1", name: "naradi"),
  //             name: "triko",
  //             checked: true,
  //             amount: 1,
  //             private: true,
  //             shared: false,
  //             userId: "1")
  //       ],
  //       role: Role.admin)
  // ]);

  // user1.trips.add(trip1.id);

  // db.collection("users").add(user1.toMap());
  // db.collection("trips").add(trip1.toMap());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trippidy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SkeletonScreen(),
    );
  }
}

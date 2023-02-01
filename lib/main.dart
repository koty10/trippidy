import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'model/enum/role.dart';
import 'model/item.dart';
import 'model/member.dart';
import 'model/trip.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var db = FirebaseFirestore.instance;

  var user1 = User(documentId: "id-membera-vnitrni", name: "Daniel");

  var trip1 = Trip(
    id: "id-tripu-vnitrni",
    name: "Dansko",
    members: {
      "id-membera": Member(
          userId: "id-membera-vnitrni",
          items: {
            "id-itemy": Item(
                documentId: "id-itemy-vnitrni",
                category: "naradi",
                name: "triko",
                checked: true,
                amount: 1,
                private: true,
                shared: true,
                userId: "id-membera")
          },
          role: Role.admin)
    },
    categories: ["naradi"],
  );

  // var trip1 = Trip(
  //   id: "1",
  //   name: "Dansko",
  //   members: {},
  //   categories: ["naradi"],
  // );

  // var member = Member(
  //     userId: "1",
  //     items: {
  //       "1": Item(
  //           documentId: "1",
  //           category: "naradi",
  //           name: "triko",
  //           checked: true,
  //           amount: 1,
  //           private: true,
  //           shared: false,
  //           userId: "1")
  //     },
  //     role: Role.admin);

  db.collection("users").doc("id-membera").set(user1.toMap());
  db.collection("trips").doc("id-tripu").set(trip1.toMap());

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

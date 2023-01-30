import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/model/user.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'model/category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(MemberAdapter())
    ..registerAdapter(TripAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(RoleAdapter());

  Hive.deleteBoxFromDisk("trips");
  await Hive.openBox<Trip>('trips');

  // DummyDataService().initHiveDb();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await db
      .collection("trips")
      .where("members", arrayContains: {"id": 2}).get();
  var docs = snapshot.docs;
  log(docs.toString());

  QuerySnapshot snapshot2 = await db.collection("trips").get();
  var docs2 = snapshot2.docs;

  QuerySnapshot snapshot3 =
      await db.collection("trips").where("members.id", isEqualTo: 2).get();
  var docs3 = snapshot3.docs;

  QuerySnapshot snapshot4 =
      await db.collection("trips").where("owner.id", isEqualTo: 1).get();
  var docs4 = snapshot4.docs;

  // Add a new document with a generated ID
  // log(Hive.box<Trip>("trips").toString());
  // for (var trip in Hive.box<Trip>("trips").values) {
  //   log(trip.toString());
  //   db
  //       .collection("trips")
  //       .add(trip.toMap())
  //       .then((DocumentReference doc) =>
  //           log('DocumentSnapshot added with ID: ${doc.id}'))
  //       .catchError((err) {
  //     log(err.toString());
  //   });
  // }

  runApp(const ProviderScope(child: MyApp()));
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

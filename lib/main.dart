import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/model/user.dart';
import 'package:trippidy/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(MemberAdapter())
    ..registerAdapter(TripAdapter())
    ..registerAdapter(UserAdapter());

  await Hive.openBox<Trip>('trips');

  // DummyDataService().initHiveDb();

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //var db = FirebaseFirestore.instance;

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

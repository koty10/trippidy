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
  await Hive.initFlutter();
  Hive
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(MemberAdapter())
    ..registerAdapter(TripAdapter())
    ..registerAdapter(UserAdapter());

  await Hive.openBox<Trip>('trips');

  //DummyDataService().initHiveDb();

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

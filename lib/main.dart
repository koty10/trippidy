import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:trippidy/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/screens/login/login_screen.dart';
import 'package:trippidy/screens/loading/loading_screen.dart';

import 'firebase_options.dart';
import 'model/enum/role.dart';
import 'model/item.dart';
import 'model/member.dart';
import 'model/trip.dart';
import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: GOOGLE_CLIENT_ID),
  ]);

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
        role: Role.admin,
        accepted: true,
      ),
    },
    categories: ["naradi"],
  );
  var trip2 = Trip(
    id: "id-tripu-vnitrni2",
    name: "Dansko 2",
    members: {
      "xUvFeVdl1PhNo2O6abK26tRUagB2": Member(
        userId: "xUvFeVdl1PhNo2O6abK26tRUagB2",
        items: {
          "id-itemy 2": Item(
              documentId: "id-itemy-vnitrni 2",
              category: "naradi",
              name: "triko",
              checked: true,
              amount: 1,
              private: true,
              shared: true,
              userId: "xUvFeVdl1PhNo2O6abK26tRUagB2")
        },
        role: Role.admin,
        accepted: true,
      ),
    },
    categories: ["naradi"],
  );
  db.collection("users").doc("id-membera").set(user1.toMap());
  db.collection("trips").doc("id-tripu").set(trip1.toMap());
  db.collection("trips").doc("id-tripu-2").set(trip2.toMap());

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
      home: StreamBuilder<fba.User?>(
        stream: fba.FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const LoginScreen();
          if (snapshot.hasData && snapshot.data != null) {
            return const LoadingScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

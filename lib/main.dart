import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trippidy/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/screens/login/login_screen.dart';
import 'package:trippidy/screens/loading/loading_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("user");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: GOOGLE_CLIENT_ID),
  ]);

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
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
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
      // routes: {
      //   LoginScreen.routName :(context) => LoginScreen(),
      //   TripScreen.routeName:(context) => TripScreen(currentTrip: currentTrip),
      // },

      // onGenerateRoute: (settings) {
      //   if (settings.name)
      // },
    );
  }
}

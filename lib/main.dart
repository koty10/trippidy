import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:trippidy/model/hive/credentials_wrapper.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/screens/loading/loading_screen.dart';
import 'package:trippidy/screens/login/login_screen.dart';
import 'package:trippidy/screens/new_profile/new_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Hive.initFlutter();
  Hive.registerAdapter(CredentialsWrapperAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    precacheImage(const AssetImage("assets/images/trip_illustration.jpg"), context);
    precacheImage(const AssetImage("assets/images/future_payments.jpg"), context);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // supportedLocales: const [Locale('cs'), Locale("en_US")],
      // locale: const Locale("cs"),
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
      home: authState.isAuthenticated
          ? authState.userProfile!.firstname.isNotEmpty && authState.userProfile!.lastname.isNotEmpty
              ? const LoadingScreen()
              : const NewProfileScreen()
          : const LoginScreen(),
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

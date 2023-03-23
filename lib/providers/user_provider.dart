// import 'package:auth0_flutter/auth0_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
// import 'package:trippidy/model/user.dart';

// final userProvider = StateNotifierProvider<UserProvider, UserProfile>(
//   (ref) {
//     return UserProvider();
//   },
// );

// class UserProvider extends StateNotifier<UserProfile> {
//   UserProvider(super.state);

//   void setUser(User user) {
//     state = user;
//   }

//   UserProfile? _user;

//   late Auth0 auth0;

//   @override
//   void initState() {
//     super.initState();
//     auth0 = widget.auth0 ?? Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
//   }

//   Future<void> login() async {
//     var credentials = await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).login();

//     setState(() {
//       state = credentials.user;
//     });
//   }

//   Future<void> logout() async {
//     await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME']).logout();

//     setState(() {
//       _user = null;
//     });
//   }
// }

// final authProvider = StateNotifierProvider((ref) => AuthNotifier());
// var auth0 = Auth0('trippidy.eu.auth0.com', '2CGBd2OORWRiGpjvx7PQYUeLeEjuLGDj');

// class AuthNotifier extends StateNotifier<AuthState> {
//   AuthNotifier() : super(AuthState.unknown()) {
//     _init();
//   }

//   Future<void> _init() async {
//     final isAuthenticated = await auth0.webAuthentication()
//       ..isAuthenticated;
//     if (isAuthenticated) {
//       final userProfile = await Auth0Flutter.instance.getUserProfile();
//       state = AuthState.authenticated(userProfile);
//     } else {
//       state = AuthState.unauthenticated();
//     }
//   }
 
//   Future<void> login() async {
//     final result = await auth0.webAuthentication().login();
//     Hive.box("userProfile").add(value).get("id")
//     if (result.idToken) {
//       state = AuthState.authenticated(result.profile);
//     } else {
//       state = AuthState.unauthenticated();
//     }
//   }

//   Future<void> logout() async {
//     await Auth0Flutter.instance.logout();
//     state = AuthState.unauthenticated();
//   }
// }

// class AuthState {
//   final bool isAuthenticated;
//   final UserProfile? userProfile;

//   AuthState._({required this.isAuthenticated, this.userProfile});

//   factory AuthState.unknown() => AuthState._(isAuthenticated: false);

//   factory AuthState.authenticated(UserProfile userProfile) => AuthState._(
//         isAuthenticated: true,
//         userProfile: userProfile,
//       );

//   factory AuthState.unauthenticated() => AuthState._(isAuthenticated: false);
// }

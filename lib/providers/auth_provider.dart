import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  //final auth0 = ref.watch(auth0Provider(ref.watch(auth0ConfigProvider)));
  var auth0 = Auth0('trippidy.eu.auth0.com', '2CGBd2OORWRiGpjvx7PQYUeLeEjuLGDj');
  return AuthNotifier(auth0);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._auth0) : super(AuthState.unauthenticated()) {
    _init();
  }

  final Auth0 _auth0;

  Future<void> _init() async {
    final token = await HiveAuthStorage.getToken();
    //final user = await HiveAuthStorage.getUser();
    if (token != null) {
      // && user != null) {
      state = AuthState.authenticated(token);
    } else {
      login();
    }
  }

  Future<void> login() async {
    final credentials = await _auth0.webAuthentication(scheme: "com.example.trippidy").login();
    log(credentials.toString());
    //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
    //final user = User.fromJson(credentials.user);
    await HiveAuthStorage.storeToken(credentials.idToken);
    //await HiveAuthStorage.storeUser(user);
    state = AuthState.authenticated(credentials.idToken);
  }

  Future<void> logout() async {
    await HiveAuthStorage.deleteToken();
    //await HiveAuthStorage.deleteUser();
    state = AuthState.unauthenticated();
  }
}

class AuthState {
  AuthState._(this.idToken);

  factory AuthState.unauthenticated() => AuthState._(null);

  factory AuthState.authenticated(String idToken) => AuthState._(idToken);

  final String? idToken;

  bool get isAuthenticated => idToken != null;
}

class HiveAuthStorage {
  static const String _tokenBox = 'tokenBox';
  // static const String _userBox = 'userBox';

  static Future<void> storeToken(String token) async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.put('token', token);
    await box.close();
  }

  static Future<String?> getToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    final token = box.get('token');
    await box.close();
    return token;
  }

  static Future<void> deleteToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.delete('token');
    await box.close();
  }

  // static Future<void> storeUser(User user) async {
  //   final box = await Hive.openBox<User>(_userBox);
  //   await box.put('user', user);
  //   await box.close();
  // }

  // static Future<User?> getUser() async {
  //   final box = await Hive.openBox<User>(_userBox);
  //   final user = box.get('user');
  //   await box.close();
  //   return user;
  // }

  // static Future<void> deleteUser() async {
  //   final box = await Hive.openBox<User>(_userBox);
  //   await box.delete('user');
  //   await box.close();
  //}
}

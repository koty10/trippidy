import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decode/jwt_decode.dart'; //TODO use diferent package or approach

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
    final idToken = await HiveAuthStorage.getIdToken();
    final accessToken = await HiveAuthStorage.getAccessToken();
    final refreshToken = await HiveAuthStorage.getRefreshToken();
    //final user = await HiveAuthStorage.getUser();

    if (idToken != null || refreshToken != null || accessToken != null) {
      // && user != null) {
      state = AuthState.authenticated(idToken!, accessToken!, refreshToken!);
    } else {
      login();
    }
  }

  Future<void> login() async {
    final credentials = await _auth0.webAuthentication(scheme: "com.example.trippidy").login();
    log(credentials.toString());
    //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
    //final user = User.fromJson(credentials.user);
    await HiveAuthStorage.storeIdToken(credentials.idToken);
    await HiveAuthStorage.storeAccessToken(credentials.accessToken);
    await HiveAuthStorage.storeRefreshToken(credentials.refreshToken!);
    //await HiveAuthStorage.storeUser(user);
    state = AuthState.authenticated(credentials.idToken, credentials.accessToken, credentials.refreshToken!);
  }

  Future<void> logout() async {
    await HiveAuthStorage.deleteIdToken();
    //await HiveAuthStorage.deleteUser();
    state = AuthState.unauthenticated();
  }

  Future<void> refresh() async {
    var credentials = await _auth0.api.renewCredentials(refreshToken: (await HiveAuthStorage.getRefreshToken())!); //FIXME - null
    log(credentials.toString());
    //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
    //final user = User.fromJson(credentials.user);
    await HiveAuthStorage.storeIdToken(credentials.idToken);
    await HiveAuthStorage.storeAccessToken(credentials.accessToken);
    await HiveAuthStorage.storeRefreshToken(credentials.refreshToken!);
    //await HiveAuthStorage.storeUser(user);
    state = AuthState.authenticated(credentials.idToken, credentials.accessToken, credentials.refreshToken!);
  }

  String? getIdToken() {
    return state.idToken;
  }

  static bool isTokenExpired(String token) {
    try {
      log("checking token expiration...");
      // Get the token payload
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      log(token);

      // Check if the token is expired
      if (DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000).isBefore(DateTime.now())) {
        log("token is expired");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error while checking if token is expired: $e");
      return true;
    }
  }
}

class AuthState {
  AuthState._(this.idToken, this.accessToken, this.refreshToken);

  factory AuthState.unauthenticated() => AuthState._(null, null, null);

  factory AuthState.authenticated(String idToken, String accessToken, String refreshToken) => AuthState._(idToken, accessToken, refreshToken);

  final String? idToken;
  final String? accessToken;
  final String? refreshToken;

  bool get isAuthenticated => idToken != null;
}

class HiveAuthStorage {
  static const String _tokenBox = 'tokenBox';
  // static const String _userBox = 'userBox';

  static Future<void> storeIdToken(String token) async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.put('idToken', token);
    await box.close();
  }

  static Future<void> storeAccessToken(String token) async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.put('accessToken', token);
    await box.close();
  }

  static Future<void> storeRefreshToken(String token) async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.put('refreshToken', token);
    await box.close();
  }

  static Future<String?> getIdToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    final token = box.get('idToken');

    await box.close();
    return token; //FIXME null
  }

  static Future<String?> getAccessToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    final token = box.get('accessToken');

    await box.close();
    return token; //FIXME null
  }

  static Future<String?> getRefreshToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    final token = box.get('refreshToken');

    return token;
  }

  // static Future<String> parseUserIdFromIdToken() async {
  //   final parts = await getIdToken();
  //   if (parts == null) return "";
  //   parts.split('.');
  //   if (parts.length != 3) {
  //     throw const FormatException('Invalid token');
  //   }

  //   final payload = parts[1];
  //   final normalizedPayload = base64Url.normalize(payload);
  //   final decodedPayload = base64Url.decode(normalizedPayload);

  //   final payloadMap = json.decode(utf8.decode(decodedPayload)) as Map<String, dynamic>;
  //   if (payloadMap.containsKey('sub')) {
  //     return payloadMap['sub'] as String;
  //   } else {
  //     throw Exception('User ID not found in token');
  //   }
  // }

  static Future<void> deleteIdToken() async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.delete('idToken');
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

import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
//TODO use diferent package or approach

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';

import 'auth_state.dart';
import 'hive_storage.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
Auth0 auth0provider(Auth0providerRef ref) {
  return Auth0('trippidy.eu.auth0.com', '2CGBd2OORWRiGpjvx7PQYUeLeEjuLGDj');
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    _init();
    return AuthState.unauthenticated();
  }

  Future<void> _init() async {
    final idToken = await HiveAuthStorage.getIdToken();
    final accessToken = await HiveAuthStorage.getAccessToken();
    final refreshToken = await HiveAuthStorage.getRefreshToken();
    final userId = await HiveAuthStorage.getUserId();
    //final user = await HiveAuthStorage.getUser();

    if (idToken != null && refreshToken != null && accessToken != null) {
      // && user != null) {
      state = AuthState.authenticated(idToken, accessToken, refreshToken, userId ?? ""); //FIXME userId null
      await _setUserProfile();
    }
  }

  Future<void> login() async {
    log("login started");
    final Auth0 auth = ref.read(auth0providerProvider);

    final credentials = await auth.webAuthentication(scheme: "com.example.trippidy").login();
    log(credentials.toString());
    //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
    //final user = User.fromJson(credentials.user);
    await HiveAuthStorage.storeIdToken(credentials.idToken);
    await HiveAuthStorage.storeAccessToken(credentials.accessToken);
    await HiveAuthStorage.storeRefreshToken(credentials.refreshToken!);
    await HiveAuthStorage.storeUserId(credentials.user.sub);
    //await HiveAuthStorage.storeUser(user);
    state = AuthState.authenticated(credentials.idToken, credentials.accessToken, credentials.refreshToken!, credentials.user.sub);
    await _setUserProfile();
    log("login finished");
    log(state.isAuthenticated.toString());
  }

  Future<void> logout() async {
    await HiveAuthStorage.deleteIdToken();
    await HiveAuthStorage.deleteAccessToken();
    await HiveAuthStorage.deleteRefreshToken();
    await HiveAuthStorage.deleteUserId();
    await ref.read(auth0providerProvider).webAuthentication(scheme: "com.example.trippidy").logout();

    //await HiveAuthStorage.deleteUser();
    state = AuthState.unauthenticated();
  }

  Future<void> refresh() async {
    final Auth0 auth = ref.read(auth0providerProvider);
    var credentials = await auth.api.renewCredentials(refreshToken: (await HiveAuthStorage.getRefreshToken())!); //FIXME - null
    log(credentials.toString());
    //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
    //final user = User.fromJson(credentials.user);
    await HiveAuthStorage.storeIdToken(credentials.idToken);
    await HiveAuthStorage.storeAccessToken(credentials.accessToken);
    await HiveAuthStorage.storeRefreshToken(credentials.refreshToken!);
    await HiveAuthStorage.storeUserId(credentials.user.sub);
    //await HiveAuthStorage.storeUser(user);
    state = AuthState.authenticated(credentials.idToken, credentials.accessToken, credentials.refreshToken!, credentials.user.sub);
    await _setUserProfile();
  }

  String? getIdToken() {
    return state.idToken;
  }

  Future<void> _setUserProfile() async {
    final result = await ref.read(apiCallerProvider).getUserProfile();
    log(result.toString());
    state = state.copyWith(userProfile: result);
  }
}

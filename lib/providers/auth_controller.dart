import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import '../constants.dart';
import '../model/hive/credentials_wrapper.dart';
import '../model/state/auth_state.dart';
import '../model/user_profile.dart' as trippidy_user_profile;
import '../storage/hive_auth_storage.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
Auth0 auth0provider(Auth0providerRef ref) {
  return Auth0(AUTH0_DOMAIN, AUTH0_CLIENT_ID);
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    _init();
    return AuthState.unauthenticated();
  }

  Future<void> _init() async {
    final credentials = await HiveAuthStorage.getCredentials();

    if (credentials != null) {
      state = AuthState.authenticated(credentials);
      await _setUserProfile();
    }
  }

  Future<void> login() async {
    log("login started");
    final Auth0 auth = ref.read(auth0providerProvider);

    try {
      final credentials = await auth.webAuthentication(scheme: AUTH0_SCHEME).login();
      log(credentials.toString());
      //final userInfo = credentials.idToken; // .userInfo({'access_token': credentials['access_token']});
      //final user = User.fromJson(credentials.user);
      await HiveAuthStorage.storeCredentials(credentials);
      //await HiveAuthStorage.storeUser(user);
      state = AuthState.authenticated(
        CredentialsWrapper(
          idToken: credentials.idToken,
          accessToken: credentials.accessToken,
          refreshToken: credentials.refreshToken,
          userId: credentials.user.sub,
        ),
      );
      await _setUserProfile();
      log("login finished");
      log(state.isAuthenticated.toString());
    } catch (e) {
      log("User was not able to login using Auth0.");
    }
  }

  Future<void> logout() async {
    await HiveAuthStorage.deleteCredentials();
    await ref.read(auth0providerProvider).webAuthentication(scheme: AUTH0_SCHEME).logout();
    state = AuthState.unauthenticated();
  }

  Future<void> refresh() async {
    final Auth0 auth = ref.read(auth0providerProvider);
    final oldCredentials = await HiveAuthStorage.getCredentials();
    if (oldCredentials == null || oldCredentials.refreshToken == null) {
      state = AuthState.unauthenticated();
      return;
    }
    var credentials = await auth.api.renewCredentials(refreshToken: (oldCredentials.refreshToken!));
    log(credentials.toString());
    await HiveAuthStorage.storeCredentials(credentials);
    state = AuthState.authenticated(
      CredentialsWrapper(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
        refreshToken: credentials.refreshToken,
        userId: credentials.user.sub,
      ),
    );
    await _setUserProfile();
  }

  String? getIdToken() {
    return state.credentials?.idToken;
  }

  String? getUserId() {
    return state.credentials?.userId;
  }

  Future<void> updateUserProfile(trippidy_user_profile.UserProfile userProfile) async {
    final result = await ref.read(apiCallerProvider).updateUserProfile(userProfile);
    log(result.toString());
    state = state.copyWith(userProfile: result);
  }

  Future<void> _setUserProfile() async {
    try {
      final result = await ref.read(apiCallerProvider).getUserProfile();
      log(result.toString());
      state = state.copyWith(userProfile: result);
    } catch (e) {
      log("Could not load userProfile.");
    }
  }
}

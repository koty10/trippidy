import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/providers/trips_controller.dart';
import '../constants.dart';
import '../model/hive/credentials_wrapper.dart';
import '../model/state/auth_state.dart';
import '../model/dto/user_profile.dart' as trippidy_user_profile;
import '../storage/hive_auth_storage.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
Auth0 auth0provider(Auth0providerRef ref) {
  return Auth0(AUTH0_DOMAIN, AUTH0_CLIENT_ID);
}

@Riverpod(keepAlive: true)
Auth0Web auth0webProvider(Auth0webProviderRef ref) {
  return Auth0Web(AUTH0_WEB_DOMAIN, AUTH0_WEB_CLIENT_ID);
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    _init();
    return AuthState.unauthenticated();
  }

  Future<void> _init() async {
    // Web
    if (kIsWeb) {
      log("web auth started");
      final Auth0Web auth0Web = ref.read(auth0webProviderProvider);
      auth0Web.onLoad().then(
        // First try to get fresh credentials directly from Auth0
        (final credentials) async {
          log("web credentials: ${credentials?.toString() ?? "no credentials"}");
          if (credentials != null) {
            await HiveAuthStorage.storeCredentials(credentials);
            final hiveCredentials = await HiveAuthStorage.getCredentials();
            log("init: stored web credentials to hive: ${hiveCredentials?.toString() ?? "no credentials"}");

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
          } else {
            // If there are no fresh credentials, I get them from Hive
            final credentials = await HiveAuthStorage.getCredentials();
            log("web credentials hive: ${credentials?.toString() ?? "no credentials"}");
            if (credentials != null) {
              state = AuthState.authenticated(
                CredentialsWrapper(
                  idToken: credentials.idToken,
                  accessToken: credentials.accessToken,
                  refreshToken: credentials.refreshToken,
                  userId: credentials.userId,
                ),
              );
              await _setUserProfile();
              log("login finished");
              log(state.isAuthenticated.toString());
            }
          }
        },
      );
    }
    // Android
    else {
      final credentials = await HiveAuthStorage.getCredentials();
      log("_init refresh token: ${credentials?.refreshToken}");

      if (credentials != null) {
        state = AuthState.authenticated(credentials);
        await _setUserProfile();
      }
    }
  }

  Future<void> login() async {
    log("login started");
    // Web
    if (kIsWeb) {
      final Auth0Web auth0Web = ref.read(auth0webProviderProvider);
      await auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
    }
    // Android
    else {
      final Auth0 auth = ref.read(auth0providerProvider);

      try {
        final credentials = await auth.webAuthentication(scheme: AUTH0_SCHEME).login();
        log(credentials.toString());
        log("refresh token: ${credentials.refreshToken}");
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
  }

  Future<void> logout() async {
    await HiveAuthStorage.deleteCredentials();
    await ref.read(auth0providerProvider).webAuthentication(scheme: AUTH0_SCHEME).logout();
    state = AuthState.unauthenticated();
  }

  Future<void> refresh() async {
    final Auth0 auth = ref.read(auth0providerProvider);
    final oldCredentials = await HiveAuthStorage.getCredentials();
    log(oldCredentials.toString());
    if (oldCredentials == null || oldCredentials.refreshToken == null) {
      state = AuthState.unauthenticated();
      log("Could not load a refresh token. Setting AuthState to unauthenticated");
      return;
    }
    log("Using a refresh token to renewCredentials");
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

  Future<bool> updateUserProfile(trippidy_user_profile.UserProfile userProfile) async {
    try {
      final result = await ref.read(apiCallerProvider).updateUserProfile(userProfile);
      log(result.toString());
      state = state.copyWith(userProfile: result);
      ref.read(tripsControllerProvider.notifier).loadTrips();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
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

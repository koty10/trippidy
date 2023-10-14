// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:trippidy/model/hive/credentials_wrapper.dart';

import '../dto/user_profile.dart' as trippidy_user_profile;

class AuthState {
  AuthState._({this.credentials, this.userProfile});

  factory AuthState.unauthenticated() => AuthState._(
        credentials: null,
        userProfile: null,
      );

  factory AuthState.authenticated(CredentialsWrapper credentials) => AuthState._(credentials: credentials);

  final CredentialsWrapper? credentials;
  final trippidy_user_profile.UserProfile? userProfile;

  bool get isAuthenticated => userProfile != null;

  AuthState copyWith({
    CredentialsWrapper? credentials,
    trippidy_user_profile.UserProfile? userProfile,
  }) {
    return AuthState._(
      credentials: credentials ?? this.credentials,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

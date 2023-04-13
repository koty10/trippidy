// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trippidy/model/user_profile.dart';

class AuthState {
  AuthState._({this.idToken, this.accessToken, this.refreshToken, this.userId, this.userProfile});

  factory AuthState.unauthenticated() => AuthState._(
        idToken: null,
        accessToken: null,
        refreshToken: null,
        userId: null,
        userProfile: null,
      );

  factory AuthState.authenticated(String idToken, String accessToken, String refreshToken, String userId) =>
      AuthState._(idToken: idToken, accessToken: accessToken, refreshToken: refreshToken, userId: userId);

  final String? idToken;
  final String? accessToken;
  final String? refreshToken;
  final String? userId; // TODO maybe i won't need this
  final UserProfile? userProfile;

  bool get isAuthenticated => userProfile != null;

  AuthState copyWith({
    String? idToken,
    String? accessToken,
    String? refreshToken,
    String? userId,
    UserProfile? userProfile,
  }) {
    return AuthState._(
      idToken: idToken ?? this.idToken,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:hive/hive.dart';
import 'package:trippidy/model/hive/credentials_wrapper.dart';

class HiveAuthStorage {
  static const String _credentialsBox = 'credentialsBox';

  static Future<void> storeCredentials(Credentials credentials) async {
    final box = await Hive.openBox<CredentialsWrapper>(_credentialsBox);
    await box.put('credentials', CredentialsWrapper(idToken: credentials.idToken, accessToken: credentials.accessToken, refreshToken: credentials.refreshToken, userId: credentials.user.sub));
    await box.close();
  }

  static Future<CredentialsWrapper?> getCredentials() async {
    final box = await Hive.openBox<CredentialsWrapper>(_credentialsBox);
    final credentials = box.get('credentials');
    await box.close();
    return credentials;
  }

  static Future<void> deleteCredentials() async {
    final box = await Hive.openBox<CredentialsWrapper>(_credentialsBox);
    await box.delete('credentials');
    await box.close();
  }
}

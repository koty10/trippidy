import 'package:hive/hive.dart';

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

  static Future<void> storeUserId(String token) async {
    final box = await Hive.openBox<String>(_tokenBox);
    await box.put('userId', token);
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

  static Future<String?> getUserId() async {
    final box = await Hive.openBox<String>(_tokenBox);
    final token = box.get('userId');

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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'credentials_wrapper.g.dart';

@HiveType(typeId: 0)
class CredentialsWrapper extends HiveObject {
  @HiveField(0)
  String idToken;
  @HiveField(1)
  String accessToken;
  @HiveField(2)
  String? refreshToken;
  @HiveField(3)
  String userId;

  CredentialsWrapper({
    required this.idToken,
    required this.accessToken,
    this.refreshToken,
    required this.userId,
  });
}

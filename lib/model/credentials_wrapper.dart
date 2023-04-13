// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'credentials_wrapper.g.dart';

@HiveType(typeId: 0)
class CredentialsWrapper {
  @HiveField(0)
  Credentials credentials;

  CredentialsWrapper({
    required this.credentials,
  });
}

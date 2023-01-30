import 'package:hive/hive.dart';
part 'role.g.dart';

@HiveType(typeId: 5)
enum Role {
  @HiveField(0)
  member,
  @HiveField(1)
  admin
}

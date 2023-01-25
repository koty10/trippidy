import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  User({required this.name, required this.id});

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
}

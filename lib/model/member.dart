import 'package:anti_forgetter/model/item.dart';
import 'package:anti_forgetter/model/user.dart';
import 'package:hive/hive.dart';
part 'member.g.dart';

@HiveType(typeId: 1)
class Member {
  Member({required this.user, required this.items, required this.id});

  @HiveField(0)
  int id;
  @HiveField(1)
  User user;
  @HiveField(2)
  List<Item> items;
}

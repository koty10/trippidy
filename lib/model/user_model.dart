import 'package:anti_forgetter/model/member_model.dart';
import 'package:isar/isar.dart';
part 'user_model.g.dart';

@collection
class UserModel {
  UserModel() : name = "";

  Id id = Isar.autoIncrement;
  String name;

  @Backlink(to: "user")
  final members = IsarLinks<MemberModel>();
}

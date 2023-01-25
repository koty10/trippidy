import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/model/user_model.dart';
import 'package:isar/isar.dart';
part 'trip_member_list_model.g.dart';

@collection
class MemberModel {
  Id id = Isar.autoIncrement;
  final user = IsarLink<UserModel>();
  final items = IsarLinks<ItemModel>();

  @Backlink(to: "members")
  final trips = IsarLinks<TripModel>();
}

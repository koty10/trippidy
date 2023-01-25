import 'package:anti_forgetter/model/member_model.dart';
import 'package:isar/isar.dart';
part 'trip_model.g.dart';

@collection
class TripModel {
  TripModel() : name = "";

  Id id = Isar.autoIncrement;
  String name;
  final members = IsarLinks<MemberModel>();
}

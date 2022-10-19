import 'package:anti_forgetter/model/trip_member_list_model.dart';

class TripModel {
  TripModel({required this.name, required this.memberListCollection});
  String name;
  List<TripMemberListModel> memberListCollection;
}

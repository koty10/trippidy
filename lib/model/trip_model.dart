import 'package:anti_forgetter/model/trip_member_list_model.dart';

class TripModel {
  TripModel(
      {required this.name,
      required this.memberListCollection,
      required this.myListCollection,
      required this.id});
  int id;
  String name;
  List<TripMemberListModel> memberListCollection;
  TripMemberListModel myListCollection;
}

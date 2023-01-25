import 'package:anti_forgetter/model/list_item_model.dart';
import 'package:anti_forgetter/model/user_model.dart';

class TripMemberListModel {
  TripMemberListModel({required this.user, required this.listItemCollection});

  UserModel user;
  List<ListItemModel> listItemCollection;
}

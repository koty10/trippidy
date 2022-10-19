import 'package:anti_forgetter/model/item_model.dart';

class ListItemModel {
  ListItemModel(
      {required this.item,
      required this.checked,
      required this.amount,
      required this.private,
      required this.shared,
      required this.userId});

  ItemModel item;
  bool checked;
  int amount;
  bool private;
  bool shared;

  int userId;
  // možná to tu bude chtít zpětnou referenci na tripMemberListModel, potažmo na Usera
}

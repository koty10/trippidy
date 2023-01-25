import 'package:anti_forgetter/model/item_base_model.dart';
import 'package:anti_forgetter/model/member_model.dart';
import 'package:isar/isar.dart';
part 'list_item_model.g.dart';

@collection
class ItemModel {
  ItemModel()
      : checked = false,
        amount = 0,
        private = false,
        shared = false,
        userId = 0;

  Id id = Isar.autoIncrement;
  final item = IsarLink<ItemBaseModel>();
  bool checked;
  int amount;
  bool private;
  bool shared;

  int userId;
  // možná to tu bude chtít zpětnou referenci na tripMemberListModel, potažmo na Usera

  @Backlink(to: "items")
  final member = IsarLink<MemberModel>();
}

import 'package:anti_forgetter/model/item_model.dart';

class ListItemModel {
  ListItemModel(
      {required this.item, required this.checked, required this.amount});

  ItemModel item;
  bool checked;
  int amount;
}

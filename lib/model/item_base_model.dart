import 'package:anti_forgetter/model/category_model.dart';
import 'package:anti_forgetter/model/item_model.dart';
import 'package:isar/isar.dart';
part 'item_model.g.dart';

@collection
class ItemBaseModel {
  ItemBaseModel() : name = "";

  Id id = Isar.autoIncrement;
  final category = IsarLink<CategoryModel>();
  String name;

  @Backlink(to: "item")
  final itemModels = IsarLinks<ItemModel>();
}

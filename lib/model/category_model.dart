import 'package:anti_forgetter/model/item_base_model.dart';
import 'package:isar/isar.dart';
part 'category_model.g.dart';

@collection
class CategoryModel {
  CategoryModel() : name = "";

  Id id = Isar.autoIncrement;
  String name;

  @Backlink(to: "category")
  final itemBaseCollection = IsarLinks<ItemBaseModel>();
}

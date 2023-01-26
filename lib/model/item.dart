import 'package:trippidy/model/category.dart';
import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 3)
class Item {
  Item({
    required this.id,
    required this.category,
    required this.name,
    required this.checked,
    required this.amount,
    required this.private,
    required this.shared,
    required this.userId,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  Category category;
  @HiveField(2)
  String name;
  @HiveField(3)
  bool checked;
  @HiveField(4)
  int amount;
  @HiveField(5)
  bool private;
  @HiveField(6)
  bool shared;

  // backlink
  @HiveField(7)
  int userId;
}

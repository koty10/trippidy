import 'package:anti_forgetter/model/category.dart';

class Item {
  Category category;
  String name;
  bool checked;
  int amount;
  bool private;
  bool shared;

  Item({
    required this.category,
    required this.name,
    required this.checked,
    required this.amount,
    required this.private,
    required this.shared,
  });
}

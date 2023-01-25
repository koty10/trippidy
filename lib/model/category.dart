import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 4)
class Category {
  Category({required this.id, required this.name});

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
}

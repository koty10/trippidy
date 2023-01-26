// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:trippidy/model/category.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'name': name,
      'checked': checked,
      'amount': amount,
      'private': private,
      'shared': shared,
      'userId': userId,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      name: map['name'] as String,
      checked: map['checked'] as bool,
      amount: map['amount'] as int,
      private: map['private'] as bool,
      shared: map['shared'] as bool,
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}

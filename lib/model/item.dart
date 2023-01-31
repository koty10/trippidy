// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trippidy/model/category.dart';

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

  String id;
  Category category;
  String name;
  bool checked;
  int amount;
  bool private;
  bool shared;

  // backlink
  String userId;

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
      id: map['id'] as String,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      name: map['name'] as String,
      checked: map['checked'] as bool,
      amount: map['amount'] as int,
      private: map['private'] as bool,
      shared: map['shared'] as bool,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}

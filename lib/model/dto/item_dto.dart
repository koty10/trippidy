// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemDto {
  ItemDto({
    required this.id,
    required this.category,
    required this.name,
    required this.checked,
    required this.amount,
    required this.private,
    required this.shared,
    required this.memberId,
  });

  String id;
  String category;
  String name;
  bool checked;
  int amount;
  bool private;
  bool shared;

  // backlink
  String memberId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'name': name,
      'checked': checked,
      'amount': amount,
      'private': private,
      'shared': shared,
      'userId': memberId,
    };
  }

  factory ItemDto.fromMap(Map<String, dynamic> map) {
    return ItemDto(
      id: map['id'] as String,
      category: map['category'] as String,
      name: map['name'] as String,
      checked: map['checked'] as bool,
      amount: map['amount'] as int,
      private: map['private'] as bool,
      shared: map['shared'] as bool,
      memberId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDto.fromJson(String source) =>
      ItemDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

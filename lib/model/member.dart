// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/user.dart';

part 'member.g.dart';

@HiveType(typeId: 1)
class Member {
  @HiveField(0)
  int id;
  @HiveField(1)
  User user;
  @HiveField(2)
  List<Item> items;
  Member({
    required this.id,
    required this.user,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      items: List<Item>.from(
        (map['items'] as List<int>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) =>
      Member.fromMap(json.decode(source) as Map<String, dynamic>);
}

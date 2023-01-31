// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trippidy/model/item.dart';

import '../enum/role.dart';

class MemberDto {
  String id;
  String user;
  List<Item> items;
  Role role;

  MemberDto({
    required this.id,
    required this.user,
    required this.items,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'items': items.map((x) => x.toMap()).toList(),
      'role': role.name,
    };
  }

  factory MemberDto.fromMap(Map<String, dynamic> map) {
    return MemberDto(
      id: map['id'] as String,
      user: map['user'] as String,
      items: List<Item>.from(
        (map['items'] as List<int>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
      role: Role.values.byName(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberDto.fromJson(String source) =>
      MemberDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

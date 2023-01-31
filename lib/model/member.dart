// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trippidy/model/dto/member_dto.dart';

import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/user.dart';

import 'enum/role.dart';

class Member {
  String id;
  User user;
  List<Item> items;
  Role role;
  Member({
    required this.id,
    required this.user,
    required this.items,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'role': role.name,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      items: List<Item>.from(
        (map['items'] as List<int>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
      role: Role.values.byName(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) =>
      Member.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Member.fromDto(MemberDto memberDto, User user) {
    return Member(
        id: memberDto.id,
        user: user,
        items: memberDto.items,
        role: memberDto.role);
  }
}

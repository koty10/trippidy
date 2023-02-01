// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:trippidy/model/item.dart';

import 'enum/role.dart';

class Member {
  String userId;
  Map<String, Item> items;
  Role role;
  Member({
    required this.userId,
    required this.items,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((key, value) => MapEntry(key, value.toMap())),
      'role': role.name,
    };
  }

  factory Member.fromMap(String userId, Map<String, dynamic> map) {
    Map<String, Item> items = {};
    map['items'].forEach((documentId, itemsDynamic) {
      items[documentId] = Item.fromMap(documentId, itemsDynamic);
    });

    return Member(
      userId: userId,
      items: items,
      role: Role.values.byName(map['role']),
    );
  }
}

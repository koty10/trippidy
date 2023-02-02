// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/user.dart';

import 'enum/role.dart';

class Member {
  String userId;
  Map<String, Item> items;
  Role role;
  bool accepted;
  Member({
    required this.userId,
    required this.items,
    required this.role,
    required this.accepted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((key, value) => MapEntry(key, value.toMap())),
      'role': role.name,
      'accepted': accepted,
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
      accepted: map['accepted'] as bool,
    );
  }

  Future<User> fetchUser() async {
    var db = FirebaseFirestore.instance;
    var userData = (await db.collection('users').doc(userId).get()).data();
    if (userData != null) return User.fromMap(userId, userData);
    return User(documentId: " ", name: " ");
  }
}

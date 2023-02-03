// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:trippidy/model/member.dart';

class Trip {
  String id;
  String name;
  Map<String, Member> members;
  List<String> categories;
  Trip({
    this.id = "",
    required this.name,
    required this.members,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'members': members.map((key, value) => MapEntry(key, value.toMap())),
      'categories': categories
    };
  }

  // factory Trip.fromMap(Map<String, dynamic> map) {
  //   return Trip(
  //     id: map['id'] as String,
  //     name: map['name'] as String,
  //     members: List<Member>.from(
  //       (map['members'] as List<int>).map<Member>(
  //         (x) => Member.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }

  factory Trip.fromMap(String documentId, Map<String, dynamic> data) {
    Map<String, Member> members = {};
    data['members'].forEach((userId, membersDynamic) {
      members[userId] = Member.fromMap(userId, membersDynamic);
    });

    return Trip(
      id: documentId,
      name: data['name'],
      members: members,
      categories: List<String>.from(data['categories']),
    );
  }
}

import 'dart:convert';

import 'item.dart';

Member memberFromJson(String str) => json.decode(str);

String memberToJson(Member data) => json.encode(data);

class Member {
  Member({
    required this.accepted,
    required this.id,
    required this.items,
    required this.role,
    required this.tripId,
    required this.userProfileFirstname,
    required this.userProfileLastname,
    required this.userProfileId,
    this.userProfileImage,
  });

  bool accepted;
  String id;
  List<Item> items;
  String role;
  String tripId;
  String userProfileFirstname;
  String userProfileLastname;
  String userProfileId;
  String? userProfileImage;

  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.price);

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        accepted: json["accepted"],
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        role: json["role"],
        tripId: json["tripId"],
        userProfileFirstname: json["userProfileFirstname"],
        userProfileLastname: json["userProfileLastname"],
        userProfileId: json["userProfileId"],
        userProfileImage: json["userProfileImage"],
      );

  Map<String, dynamic> toJson() => {
        "accepted": accepted,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "role": role,
        "tripId": tripId,
        "userProfileFirstname": userProfileFirstname,
        "userProfileLastname": userProfileLastname,
        "userProfileId": userProfileId,
        "userProfileImage": userProfileImage,
      };

  Member copyWith({
    bool? accepted,
    String? id,
    List<Item>? items,
    String? role,
    String? tripId,
    String? userProfileFirstname,
    String? userProfileLastname,
    String? userProfileId,
    String? userProfileImage,
  }) {
    return Member(
      accepted: accepted ?? this.accepted,
      id: id ?? this.id,
      items: items ?? this.items,
      role: role ?? this.role,
      tripId: tripId ?? this.tripId,
      userProfileFirstname: userProfileFirstname ?? this.userProfileFirstname,
      userProfileLastname: userProfileLastname ?? this.userProfileLastname,
      userProfileId: userProfileId ?? this.userProfileId,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }
}

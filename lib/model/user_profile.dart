// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

import 'member.dart';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.firstname,
    required this.id,
    required this.image,
    required this.lastname,
    required this.members,
  });

  String firstname;
  String id;
  String image;
  String lastname;
  List<Member> members;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstname: json["firstname"],
        id: json["id"],
        image: json["image"],
        lastname: json["lastname"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "id": id,
        "image": image,
        "lastname": lastname,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

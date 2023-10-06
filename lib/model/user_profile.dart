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
    required this.bankAccountNumber,
    required this.iban,
  });

  String firstname;
  String id;
  String image;
  String lastname;
  List<Member> members;
  String bankAccountNumber;
  String iban;

  factory UserProfile.initial() {
    return UserProfile(
      firstname: '',
      id: '',
      image: '',
      lastname: '',
      members: [],
      bankAccountNumber: '',
      iban: '',
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstname: json["firstname"],
        id: json["id"],
        image: json["image"],
        lastname: json["lastname"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        bankAccountNumber: json["bankAccountNumber"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "id": id,
        "image": image,
        "lastname": lastname,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "bankAccountNumber": bankAccountNumber,
        "iban": iban,
      };

  @override
  String toString() {
    return "$id, $firstname, $lastname, $image, $bankAccountNumber, $iban";
  }

  UserProfile copyWith({
    String? id,
    List<Member>? members,
    String? firstname,
    String? lastname,
    String? image,
    String? bankAccountNumber,
    String? iban,
  }) {
    return UserProfile(
      id: id ?? this.id,
      members: members ?? this.members,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      image: image ?? this.image,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      iban: iban ?? this.iban,
    );
  }
}

// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

import 'member.dart';

Trip tripFromJson(String str) => json.decode(str);

String tripToJson(Trip data) => json.encode(data.toJson());

List<Trip> tripCollectionFromJson(String str) => List<Trip>.from(json.decode(str).map((x) => Trip.fromJson(x)));

String tripCollectionToJson(List<Trip> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trip {
  Trip({
    this.dateFrom,
    this.dateTo,
    required this.id,
    required this.members,
    required this.name,
    required this.isDeleted,
  });

  factory Trip.empty() {
    return Trip(dateFrom: DateTime.now(), dateTo: DateTime.now(), id: "", members: [], name: "", isDeleted: false);
  }

  DateTime? dateFrom;
  DateTime? dateTo;
  String id;
  List<Member> members;
  String name;
  bool isDeleted;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        dateFrom: json["dateFrom"] != null ? DateTime.parse(json["dateFrom"]) : null,
        dateTo: json["dateTo"] != null ? DateTime.parse(json["dateTo"]) : null,
        id: json["id"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        name: json["name"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "dateFrom": dateFrom?.toIso8601String(),
        "dateTo": dateTo?.toIso8601String(),
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "name": name,
        "isDeleted": isDeleted,
      };

  Trip copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    String? id,
    List<Member>? members,
    String? name,
    bool? isDeleted,
  }) {
    return Trip(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      id: id ?? this.id,
      members: members ?? this.members,
      name: name ?? this.name,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Member getOwner() {
    return members.firstWhere((element) => element.role == "admin");
  }
}

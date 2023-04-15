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
    required this.dateFrom,
    required this.dateTo,
    required this.id,
    required this.members,
    required this.name,
  });

  DateTime dateFrom;
  DateTime dateTo;
  String id;
  List<Member> members;
  String name;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
        id: json["id"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "dateFrom": dateFrom.toIso8601String(),
        "dateTo": dateTo.toIso8601String(),
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "name": name,
      };

  Trip copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    String? id,
    List<Member>? members,
    String? name,
  }) {
    return Trip(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      id: id ?? this.id,
      members: members ?? this.members,
      name: name ?? this.name,
    );
  }
}

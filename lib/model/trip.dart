// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trippidy/model/member.dart';

import 'dto/trip_dto.dart';

class Trip {
  String id;
  String name;
  List<Member> members;
  Trip({
    required this.id,
    required this.name,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      name: map['name'] as String,
      members: List<Member>.from(
        (map['members'] as List<int>).map<Member>(
          (x) => Member.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) =>
      Trip.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Trip.fromDto(TripDto tripDto, List<Member> members) {
    var result = Trip(
      id: tripDto.id,
      name: tripDto.name,
      members: members,
    );
    return result;
  }
}

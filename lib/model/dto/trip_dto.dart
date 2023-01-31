// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'member_dto.dart';

class TripDto {
  String id;
  String name;
  List<MemberDto> members;
  TripDto({
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

  factory TripDto.fromMap(Map<String, dynamic> map) {
    return TripDto(
      id: map['id'] as String,
      name: map['name'] as String,
      members: List<MemberDto>.from(
        (map['members'] as List<dynamic>).map<MemberDto>(
          (x) => MemberDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripDto.fromJson(String source) =>
      TripDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

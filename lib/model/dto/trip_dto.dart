// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TripDto {
  String id;
  String name;
  List<String> members;
  TripDto({
    required this.id,
    required this.name,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'members': members,
    };
  }

  factory TripDto.fromMap(Map<String, dynamic> map) {
    return TripDto(
      id: map['id'] as String,
      name: map['name'] as String,
      members: List<String>.from(
        (map['members'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripDto.fromJson(String source) =>
      TripDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

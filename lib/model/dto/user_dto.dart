// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDto {
  String id;
  String name;

  // Helplink
  List<String> trips;
  UserDto({
    required this.id,
    required this.name,
    required this.trips,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'trips': trips,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as String,
      name: map['name'] as String,
      trips: (map['trips'] as List).map((item) => item as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

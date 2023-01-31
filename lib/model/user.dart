// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trippidy/model/dto/user_dto.dart';

class User {
  String id;
  String name;
  User({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  factory User.fromDto(UserDto userDto) {
    return User(id: userDto.id, name: userDto.name);
  }
}

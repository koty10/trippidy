import 'package:anti_forgetter/model/member.dart';

class Trip {
  Trip({
    required this.name,
    required this.members,
    required this.id,
  });

  int id;
  String name;
  List<Member> members;
}

import 'package:trippidy/model/member.dart';
import 'package:hive/hive.dart';
part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip {
  Trip({
    required this.name,
    required this.members,
    required this.id,
    required this.owner,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<Member> members;
  @HiveField(3)
  Member owner;
}

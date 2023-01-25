import 'package:anti_forgetter/model/item.dart';
import 'package:anti_forgetter/model/user.dart';

class Member {
  Member({
    required this.user,
    required this.items,
  });

  User user;
  List<Item> items;
}

import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';

extension MemberExtension on Member {
  Map<String, List<Item>> getMyListItems() {
    var tmp = items;

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

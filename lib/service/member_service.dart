import 'package:trippidy/model/item.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class MemberService {
  Future<Item> addItem(int memberId, String name, {String category = ''}) async {
    String? token = await HiveAuthStorage.getIdToken();

    // If item does not exist yet
    Item newItem = Item(
      amount: 1,
      categoryName: category.trim().toLowerCase(),
      isChecked: false,
      name: name.trim().toLowerCase(),
      price: 0,
      isPrivate: false,
      isShared: true,
      memberId: memberId,
    );

    var url = Uri.parse(baseUrl + itemsEndpoint);
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: newItem.toJson(),
    );
    if (response.statusCode == 200) {
      return itemFromJson(response.body);
    }
    throw Exception("Could not create an item");
  }
}

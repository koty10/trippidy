// import 'dart:developer';

// import 'package:trippidy/model/item.dart';
// import 'package:http/http.dart' as http;

// import '../constants.dart';
// import '../providers/auth_provider.dart';

// //TODO maybe remove this service
// class ItemService {
//   Future<void> updateItem(int tripId, Item item) async {
//     String? token = await HiveAuthStorage.getIdToken();

//     var url = Uri.parse(baseUrl + tripsEndpoint);
//     var response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//       body: item.toJson(),
//     );
//     if (response.statusCode == 200) {
//       log(response.body);
//     }
//   }
// }

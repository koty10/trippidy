import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/rest_client.dart';
import 'package:trippidy/model/trip.dart';

import '../model/item.dart';

final apiCallerProvider = Provider((ref) {
  return ApiCaller(ref.watch(restClientProvider));
});

class ApiCaller {
  final RestClient _restClient;

  ApiCaller(this._restClient);

  Future<List<Trip>> getTrips() async {
    log("get trips");
    try {
      final result = await _restClient.getTrips();
      return result.data;
    } catch (e) {
      log(e.toString());
    }
    return [];
    //TODO: check for errors;
  }

  Future<Item> updateItem(Item item) async {
    log("update item");
    try {
      log(itemToJson(item));
      final result = await _restClient.updateItem(item);
      return result.data;
    } catch (e) {
      log(e.toString());
    }
    return item;
    //TODO: check for errors;
  }
}

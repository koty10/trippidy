import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/rest_client.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/model/user_profile.dart';

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

  Future<Item> createItem(Item item) async {
    log("create item");
    try {
      log(itemToJson(item));
      final result = await _restClient.createItem(item);
      return result.data;
    } catch (e) {
      log(e.toString());
    }
    return item;
    //TODO: check for errors;
  }

  Future<Trip> createTrip(Trip item) async {
    log("create trip");
    try {
      final result = await _restClient.createTrip(item);
      return result.data;
    } catch (e) {
      log(e.toString());
    }
    return item;
    //TODO: check for errors;
  }

  Future<UserProfile> getUserProfile() async {
    log("get userProfile");
    final result = await _restClient.getUserProfile();
    return result.data;
    //TODO: check for errors;
  }
}

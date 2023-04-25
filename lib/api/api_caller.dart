import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/rest_client.dart';
import 'package:trippidy/model/member.dart';
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
      log("get trips try");
      final result = await _restClient.getTrips();
      log("get trips try done");
      log(result.data.toString());
      for (var t in result.data) {
        log("${t.id} ${t.name}");
      }
      return result.data;
    } catch (e) {
      log("problem");
      log(e.toString());
      rethrow;
    }
  }

  Future<Item> updateItem(Item item) async {
    log("update item");
    try {
      log(itemToJson(item));
      final result = await _restClient.updateItem(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Item> createItem(Item item) async {
    log("create item");
    try {
      log(itemToJson(item));
      final result = await _restClient.createItem(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Trip> createTrip(Trip item) async {
    log("create trip");
    try {
      final result = await _restClient.createTrip(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Trip> deleteTrip(Trip item) async {
    log("delete trip");
    try {
      final result = await _restClient.deleteTrip(item.id);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserProfile> getUserProfile() async {
    log("get userProfile");
    try {
      final result = await _restClient.getUserProfile();
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserProfile> updateUserProfile(UserProfile item) async {
    log("update userProfile");
    log(userProfileToJson(item));
    try {
      final result = await _restClient.updateUserProfile(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<UserProfile>> getUserProfilesByQuery(String query, String tripId) async {
    log("get userProfiles by query");
    try {
      final result = await _restClient.getUserProfilesByQuery(query, tripId);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Member> updateMember(Member item) async {
    log("update member");
    log(memberToJson(item));
    try {
      final result = await _restClient.updateMember(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Member> createMember(Member item) async {
    log("create member");
    log(memberToJson(item));
    try {
      final result = await _restClient.createMember(item);
      return result.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

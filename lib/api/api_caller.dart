import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/rest_client.dart';
import 'package:trippidy/model/trip.dart';

final apiCallerProvider = Provider((ref) {
  return ApiCaller(ref.watch(restClientProvider));
});

class ApiCaller {
  final RestClient _restClient;

  ApiCaller(this._restClient);

  Future<List<Trip>> getTrips() async {
    log("message");
    try {
      final result = await _restClient.getTrips();
      return result.data;
    } catch (e) {
      log(e.toString());
    }
    return [];
    //TODO: check for errors;
  }
}

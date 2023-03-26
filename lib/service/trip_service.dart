import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../model/enum/role.dart';

class TripService {
  Future<List<Trip>> fetchTripsForUser() async {
    String? token = await HiveAuthStorage.getIdToken();

    var url = Uri.parse(baseUrl + tripsEndpoint);
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return tripCollectionFromJson(response.body);
    }
    return [];
  }

  Future<Trip> addTripForUser(String name) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Trip newTrip = Trip(
      name: name,
      dateFrom: DateTime.now(),
      dateTo: DateTime.now(),
      members: [
        Member(
          userProfileId: userId,
          items: [],
          role: Role.admin.name,
          accepted: true,
        ),
      ],
    );

    String? token = await HiveAuthStorage.getIdToken();

    var url = Uri.parse(baseUrl + tripsEndpoint);
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: newTrip.toJson(),
    );
    if (response.statusCode == 200) {
      return tripFromJson(response.body);
    }
    throw Exception("can not create a trip");
  }
}

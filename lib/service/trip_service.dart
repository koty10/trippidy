import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';

import '../model/enum/role.dart';

class TripService {
  Future<List<Trip>> fetchTripsForUser() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var db = FirebaseFirestore.instance;
    var snapshots = await db
        .collection('trips')
        .where('members.$userId.accepted', isEqualTo: true)
        .get();

    List<Trip> trips = [];
    for (var snapshot in snapshots.docs) {
      Map<String, dynamic> data = snapshot.data();
      trips.add(Trip.fromMap(snapshot.id, data));
    }

    return trips;
  }

  Future<Trip> addTripForUser(String name) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Trip newTrip = Trip(
      name: name,
      members: {
        userId:
            Member(userId: userId, items: {}, role: Role.admin, accepted: true),
      },
      categories: [],
    );

    var db = FirebaseFirestore.instance;
    var newTripDocument = await db.collection('trips').add(newTrip.toMap());
    newTrip.id = newTripDocument.id;

    return newTrip;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/trip.dart';

class TripDao {
  Future<List<Trip>> fetchTripsForUser() async {
    String userId = FirebaseAuth.instance.currentUser!.uid; // TODO add
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
}

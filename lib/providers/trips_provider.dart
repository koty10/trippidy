import 'package:flutter/material.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/screens/trip/trip_screen.dart';
import 'package:trippidy/service/trip_service.dart';

final tripsProvider = StateNotifierProvider<TripsProvider, List<Trip>>((ref) {
  TripService service = TripService();
  return TripsProvider([], service);
});

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripsProvider extends StateNotifier<List<Trip>> {
  TripsProvider(super.state, this._service) {
    //initFromFirebase();
  }

  final TripService _service;

  Future<void> initFromFirebase() async {
    var trips = await _service.fetchTripsForUser();
    // var trips = TripService().fetchTripsForUser();
    //var trips = Hive.box<Trip>('trips').values.toList();
    state = trips;
  }

  Future<void> addTripForUser(context, String name) async {
    var newTrip = await _service.addTripForUser(name);
    // var newTrip = await TripService().addTripForUser(name);
    state = state += [newTrip];

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripScreen(
          currentTrip: newTrip,
        ),
      ),
    );
  }
}

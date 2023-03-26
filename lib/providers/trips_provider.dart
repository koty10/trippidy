import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/service/trip_service.dart';

import '../model/trip.dart';
import '../screens/trip/trip_screen.dart';

final tripsProvider = StateNotifierProvider<TripsProvider, AsyncValue<List<Trip>>>((ref) {
  TripService service = TripService();
  return TripsProvider(const AsyncValue.loading(), service, ref.watch(apiCallerProvider));
});

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripsProvider extends StateNotifier<AsyncValue<List<Trip>>> {
  TripsProvider(super.state, this._service, this.apiCaller) {
    //initFromFirebase();
  }

  final TripService _service;
  final ApiCaller apiCaller;

  Future<void> initFromFirebase() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      //return await _service.fetchTripsForUser();
      return await apiCaller.getTrips();

      // var trips = TripService().fetchTripsForUser();
      //var trips = Hive.box<Trip>('trips').values.toList();
    });
  }

  Future<void> addTripForUser(context, String name) async {
    var newTrip = await _service.addTripForUser(name);
    // var newTrip = await TripService().addTripForUser(name);
    if (state.isLoading || state.hasError) {
      // TODO: this should not happen but i should act somehow here
      return;
    }
    state = state..value!.add(newTrip);
    // state = state += [newTrip];

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

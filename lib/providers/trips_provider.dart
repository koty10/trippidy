import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:uuid/uuid.dart';

import '../model/enum/role.dart';
import '../model/member.dart';
import '../model/trip.dart';
import '../screens/trip/trip_screen.dart';

final tripsProvider = StateNotifierProvider<TripsProvider, AsyncValue<List<Trip>>>((ref) {
  return TripsProvider(const AsyncValue.loading(), ref.watch(apiCallerProvider));
});

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripsProvider extends StateNotifier<AsyncValue<List<Trip>>> {
  TripsProvider(super.state, this.apiCaller) {
    //initFromFirebase();
  }

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

  Future<void> addTripForUser(context, String name, String userId) async {
    var tripId = const Uuid().v4();
    Trip newTrip = Trip(
      id: tripId,
      name: name,
      dateFrom: DateTime.now(),
      dateTo: DateTime.now(),
      members: [
        Member(
          id: const Uuid().v4(),
          tripId: tripId,
          userProfileId: userId,
          items: [],
          role: Role.admin.name,
          accepted: true,
        ),
      ],
    );

    newTrip = await apiCaller.createTrip(newTrip);
    state = AsyncValue.data([newTrip, ...state.value!]);

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

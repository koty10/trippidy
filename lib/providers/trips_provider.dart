import 'package:anti_forgetter/model/trip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final tripsProvider = StateNotifierProvider<TripsProvider, List<Trip>>((ref) {
  return TripsProvider([]);
});

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripsProvider extends StateNotifier<List<Trip>> {
  TripsProvider(super.state) {
    initFromHive();
  }

  void initFromHive() {
    var trips = Hive.box<Trip>('trips').values.toList();
    state = trips;
  }
}

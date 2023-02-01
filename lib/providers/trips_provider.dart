import 'package:trippidy/model/trip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/service/trip_dao.dart';

final tripsProvider = StateNotifierProvider<TripsProvider, List<Trip>>((ref) {
  return TripsProvider([]);
});

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripsProvider extends StateNotifier<List<Trip>> {
  TripsProvider(super.state) {
    initFromFirebase();
  }

  Future<void> initFromFirebase() async {
    var trips = TripDao().fetchTripsForUser();
    //var trips = Hive.box<Trip>('trips').values.toList();
    state = await trips;
  }
}

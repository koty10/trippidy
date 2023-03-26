import 'package:trippidy/model/trip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripDetailProvider = StateNotifierProvider<TripDetailProvider, Trip>(
  (ref) {
    return TripDetailProvider(
      Trip(
        dateFrom: DateTime.now(),
        dateTo: DateTime.now(),
        name: '',
        members: [],
      ),
    );
  },
);

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class TripDetailProvider extends StateNotifier<Trip> {
  TripDetailProvider(super.state);

  // void setTrip(Trip trip) {
  //   state = trip;
  // }

  // void addTripMember(context, Member member) {}
}

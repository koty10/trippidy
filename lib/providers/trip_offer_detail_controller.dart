import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trips_controller.dart';

part 'trip_offer_detail_controller.g.dart';

@Riverpod(keepAlive: true)
class TripOfferDetailController extends _$TripOfferDetailController {
  @override
  Trip build() {
    return Trip.empty();
  }

  void setTrip(Trip trip) {
    state = trip;
  }

  void accept() {
    var loggedInUser = ref.read(authControllerProvider).userProfile!;
    state = state.copyWith(members: state.members.map((m) => m.userProfileId == loggedInUser.id ? m.copyWith(accepted: true) : m).toList());
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
    // TODO call backend
  }
}

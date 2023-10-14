import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/model/dto/trip.dart';
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

  Future<void> accept() async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    var loggedInUser = ref.read(authControllerProvider).userProfile!;
    final updatedTrip = state.copyWith(members: state.members.map((m) => m.userProfileId == loggedInUser.id ? m.copyWith(accepted: true) : m).toList());
    final updatedMember = updatedTrip.members.firstWhere((element) => element.userProfileId == loggedInUser.id);
    try {
      final result = await apiCaller.updateMember(updatedMember);
      log("povedlo se");
      log(result.userProfileFirstname);
      state = updatedTrip;
      log("Nesouhlasí:  ${state.members.where((element) => !element.accepted).length.toString()}");
      ref.read(tripsControllerProvider.notifier).updateTrip(state);
    } catch (e) {
      log("could not update a member ${updatedMember.id}");
    }
  }
}

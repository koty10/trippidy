import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/trips_controller.dart';

import '../model/member.dart';

part 'trip_detail_controller.g.dart';

@Riverpod(keepAlive: true)
class TripDetailController extends _$TripDetailController {
  @override
  Trip build() {
    return Trip.empty();
  }

  void setTrip(Trip trip) {
    state = trip;
  }

  void updateMember(Member member) {
    var updatedMembers = state.members.map((e) => e.id == member.id ? member : e).toList();
    state = state.copyWith(members: updatedMembers);
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }
}

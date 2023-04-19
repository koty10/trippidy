import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/trips_controller.dart';
import 'package:uuid/uuid.dart';

import '../api/api_caller.dart';
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

  Future<void> addMember(String userId) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    Member member = Member(
      id: const Uuid().v4(),
      accepted: false,
      items: [],
      role: Role.member.toString(),
      tripId: state.id,
      userProfileId: userId,
      userProfileFirstname: "",
      userProfileLastname: "",
      userProfileImage: "",
    );
    member = await apiCaller.createMember(member);

    // Create a new list of members with the new member added
    final updatedMembers = state.members + [member];

    // Create a new Trip object with the updated map of members
    state = state.copyWith(members: updatedMembers);
    // Update higher provider
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }
}

import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/member.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/service/member_service.dart';

import '../model/item.dart';

final memberProvider = StateNotifierProvider<MemberProvider, Member>(
  (ref) {
    return MemberProvider(
      Member(
        accepted: false,
        items: List.empty(),
        role: Role.member.name,
        userProfileId: '',
        tripId: 0,
        userProfileFirstname: "",
        userProfileImage: "",
      ),
      ref.watch(apiCallerProvider),
    );
  },
);

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class MemberProvider extends StateNotifier<Member> {
  final ApiCaller apiCaller;
  MemberProvider(super.state, this.apiCaller);

  // void setTrip(Trip trip) {
  //   state = trip;
  // }

  // void addTripMember(context, Member member) {}

  void setMember(Member member) {
    state = member;
  }

  Future<void> addItem(int tripId, String name, {String category = ''}) async {
    var newItem = await MemberService().addItem(state.id!, name, category: category); //FIXME - id null

    // Create a new map of items with the new item added
    final updatedItems = state.items + [newItem];

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
      userProfileId: state.userProfileId,
    );
    state = updatedMember;
    // Navigator.pop(context);
  }

  Future<void> updateItem(context, int tripId, Item item) async {
    apiCaller.updateItem(item);

    // Create a new map of items with the updated item
    final updatedItems = state.items.map((e) => e.id == item.id ? item : e).toList();

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
    );
    state = updatedMember;
    //Navigator.pop(context);
  }
}

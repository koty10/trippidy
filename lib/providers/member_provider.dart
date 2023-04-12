import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/member.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/item.dart';

final memberProvider = StateNotifierProvider<MemberProvider, Member>(
  (ref) {
    return MemberProvider(
      Member(
        accepted: false,
        items: List.empty(),
        role: Role.member.name,
        userProfileId: '',
        tripId: "",
        id: "",
        userProfileFirstname: "",
        userProfileLastname: "",
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

  Future<void> addItem(String tripId, String name, {String category = ''}) async {
    Item item = Item(
        amount: 1,
        categoryName: category.trim().toLowerCase(),
        isChecked: false,
        name: name.trim().toLowerCase(),
        price: 0,
        isPrivate: false,
        isShared: true,
        memberId: state.id, // FIXME null
        categoryId: const Uuid().v4(),
        id: const Uuid().v4());
    item = await apiCaller.createItem(item);

    // Create a new map of items with the new item added
    final updatedItems = state.items + [item];

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
      userProfileId: state.userProfileId,
      id: state.id,
      tripId: state.tripId,
      userProfileFirstname: state.userProfileFirstname,
      userProfileImage: state.userProfileImage,
      userProfileLastname: state.userProfileLastname,
    );
    state = updatedMember;
    // Navigator.pop(context);
  }

  Future<void> updateItem(context, String tripId, Item item) async {
    apiCaller.updateItem(item);

    // Create a new map of items with the updated item
    final updatedItems = state.items.map((e) => e.id == item.id ? item : e).toList();

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
      userProfileId: state.userProfileId,
      id: state.id,
      tripId: state.tripId,
      userProfileFirstname: state.userProfileFirstname,
      userProfileImage: state.userProfileImage,
      userProfileLastname: state.userProfileLastname,
    );
    state = updatedMember;
    //Navigator.pop(context);
  }
}

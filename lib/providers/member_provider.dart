import 'package:flutter/material.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/member.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/service/item_service.dart';
import 'package:trippidy/service/member_service.dart';

import '../model/item.dart';

final memberProvider = StateNotifierProvider<MemberProvider, Member>(
  (ref) {
    return MemberProvider(
      Member(accepted: false, items: {}, role: Role.member, userId: ''),
    );
  },
);

// StateNotifies always holds a state variable called "state"
// Whenever state is changed, every part of UI that is using this state gets notified
// The "state" variable is immutable - it is not possible to just remove from the list,
// you have to assign a new adjusted list
class MemberProvider extends StateNotifier<Member> {
  MemberProvider(super.state);

  // void setTrip(Trip trip) {
  //   state = trip;
  // }

  // void addTripMember(context, Member member) {}

  void setMember(Member member) {
    state = member;
  }

  Future<void> addItem(context, String tripId, String name) async {
    var newItem = MemberService().addItem(tripId, name);

    // Create a new map of items with the new item added
    final updatedItems = state.items..[(newItem).name] = newItem;

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
      userId: state.userId,
    );
    state = updatedMember;
    Navigator.pop(context);
  }

    Future<void> updateItem(context, String tripId, Item item) async {
    ItemService().updateItem(tripId, item);

    // Create a new map of items with the updated item
    final updatedItems = state.items..[item.name] = item;

    // Create a new Member object with the updated map of items
    final updatedMember = Member(
      accepted: state.accepted,
      items: updatedItems,
      role: state.role,
      userId: state.userId,
    );
    state = updatedMember;
    //Navigator.pop(context);
  }
}

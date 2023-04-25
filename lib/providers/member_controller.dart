import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:uuid/uuid.dart';

import '../api/api_caller.dart';
import '../model/enum/role.dart';
import '../model/item.dart';
import '../model/trip.dart';

part 'member_controller.g.dart';

@Riverpod(keepAlive: true)
class MemberController extends _$MemberController {
  @override
  Member build() {
    return Member(
      accepted: false,
      items: List.empty(),
      role: Role.member.name,
      userProfileId: '',
      tripId: "",
      id: "",
      userProfileFirstname: "",
      userProfileLastname: "",
      userProfileImage: "",
    );
  }

  void setMember(Member member) {
    state = member;
  }

  Member getLoggedInMemberFromTrip(Trip trip) {
    var loggedInUserId = ref.read(authControllerProvider).userProfile!.id;
    return trip.members.firstWhere((element) => element.userProfileId == loggedInUserId);
  }

  Future<void> addItem(String tripId, String name, {String category = '', required bool shared, required bool private}) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    Item item = Item(
        amount: 1,
        categoryName: category.trim().capitalize(),
        isChecked: false,
        name: name.trim().capitalize(),
        price: 0,
        isPrivate: private,
        isShared: shared,
        memberId: state.id,
        categoryId: const Uuid().v4(),
        id: const Uuid().v4());
    item = await apiCaller.createItem(item);

    // Create a new map of items with the new item added
    final updatedItems = state.items + [item];

    // Create a new Member object with the updated map of items
    state = state.copyWith(items: updatedItems);
    // Update higher provider
    ref.read(tripDetailControllerProvider.notifier).updateMember(state);

    // Navigator.pop(context);
  }

  Future<void> updateItem(context, String tripId, Item item) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    apiCaller.updateItem(item);

    // Create a new list of items with the updated item
    final updatedItems = state.items.map((e) => e.id == item.id ? item : e).toList();

    // Create a new Member object with the updated map of items
    state = state.copyWith(items: updatedItems);
    //Navigator.pop(context);
  }
}

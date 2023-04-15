import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:uuid/uuid.dart';

import '../api/api_caller.dart';
import '../model/enum/role.dart';
import '../model/item.dart';

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

  Future<void> addItem(String tripId, String name, {String category = ''}) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
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
    state = state.copyWith(items: updatedItems);
    // Update higher provider
    ref.read(tripDetailControllerProvider.notifier).updateMember(state);

    // Navigator.pop(context);
  }

  Future<void> updateItem(context, String tripId, Item item) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    apiCaller.updateItem(item);

    // Create a new map of items with the updated item
    final updatedItems = state.items.map((e) => e.id == item.id ? item : e).toList();

    // Create a new Member object with the updated map of items
    state = state.copyWith(items: updatedItems);
    //Navigator.pop(context);
  }
}

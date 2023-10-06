import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/model/future_transaction.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

import '../api/api_caller.dart';
import '../model/item.dart';
import '../model/trip.dart';

part 'member_controller.g.dart';

@Riverpod(keepAlive: true)
class MemberController extends _$MemberController {
  @override
  Member build() {
    return Member.empty();
  }

  void setMember(Member member) {
    state = member;
  }

  Member getLoggedInMemberFromTrip(Trip trip) {
    var loggedInUserId = ref.read(authControllerProvider).userProfile!.id;
    return trip.members.firstWhere((element) => element.userProfileId == loggedInUserId);
  }

  Future<void> addItem(String? id, String tripId, String name,
      {String category = '', required bool shared, required bool private, required Decimal price, required List<FutureTransaction> futureTransactions}) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    Item item = Item(
      amount: 1,
      categoryName: category.trim().capitalize(),
      isChecked: false,
      name: name.trim().capitalize(),
      price: price,
      isPrivate: private,
      isShared: shared,
      memberId: state.id,
      categoryId: const Uuid().v4(),
      id: id ?? const Uuid().v4(),
      futureTransactions: futureTransactions,
    );
    item = await apiCaller.createItem(item);

    // Create a new map of items with the new item added
    final updatedItems = state.items + [item];

    // Create a new Member object with the updated map of items
    state = state.copyWith(items: updatedItems);
    // Update higher provider
    ref.read(tripDetailControllerProvider.notifier).updateMember(state);

    _updateAllMembersFutureTransactions(futureTransactions, item);

    // Navigator.pop(context);
  }

  Future<void> updateItem(String tripId, Item item) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    apiCaller.updateItem(item);

    // Create a new list of items with the updated item
    final updatedItems = state.items.map((e) => e.id == item.id ? item : e).toList();

    // Create a new Member object with the updated map of items
    state = state.copyWith(items: updatedItems);

    _updateAllMembersFutureTransactions(item.futureTransactions, item);
  }

  // propagates changes in futureTransactions for current item to all trip members
  void _updateAllMembersFutureTransactions(List<FutureTransaction> futureTransactions, Item item) {
    final tripMembers = ref.read(tripDetailControllerProvider).members;
    for (var member in tripMembers) {
      final memberFutureTransaction = futureTransactions.firstWhereOrNull((ft) => ft.payerId == member.id);
      var updatedMemberFutureTransactions = member.futureTransactions;
      if (memberFutureTransaction == null) {
        updatedMemberFutureTransactions = member.futureTransactions.where((transaction) => transaction.itemId != item.id).toList();
      } else {
        updatedMemberFutureTransactions = member.futureTransactions + [memberFutureTransaction];
      }
      final updatedMember = member.copyWith(futureTransactions: updatedMemberFutureTransactions);
      ref.read(tripDetailControllerProvider.notifier).updateMember(updatedMember);
    }
  }
}

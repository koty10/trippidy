import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/dto/completed_transaction.dart';
import 'package:trippidy/model/enum/role.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trips_controller.dart';
import 'package:uuid/uuid.dart';

import '../api/api_caller.dart';
import '../model/dto/member.dart';

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
      role: Role.member.name,
      tripId: state.id,
      userProfileId: userId,
      userProfileFirstname: "",
      userProfileLastname: "",
      userProfileImage: "",
      userProfileEmail: "",
      futureTransactions: [],
      completedTransactionsSent: [],
      completedTransactionsReceived: [],
      userProfileBankAccountNumber: "",
      userProfileIban: "",
    );
    member = await apiCaller.createMember(member);

    // Create a new list of members with the new member added
    final updatedMembers = state.members + [member];

    // Create a new Trip object with the updated map of members
    state = state.copyWith(members: updatedMembers);
    // Update higher provider
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }

  Future<void> addCompletedTransaction(FuturePayment futurePayment) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    CompletedTransaction completedTransaction = CompletedTransaction.empty().copyWith(
      id: const Uuid().v4(),
      payerId: futurePayment.payer.id,
      payeeId: futurePayment.payee.id,
      amount: futurePayment.amount,
      isCanceled: false,
      tripId: state.id,
    );
    completedTransaction = await apiCaller.createCompletedTransaction(completedTransaction);

    // Create a new list of members with the new member added
    final updatedCompletedTransactions = state.completedTransactions + [completedTransaction];

    // Create a new Trip object with the updated map of members
    state = state.copyWith(completedTransactions: updatedCompletedTransactions);
    // Update higher provider
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }

  Future<void> deleteTrip() async {
    state = await ref.read(apiCallerProvider).deleteTrip(state);
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }

  Future<void> refreshTrip() async {
    state = await ref.read(apiCallerProvider).getTrip(state.id);
    ref.read(tripsControllerProvider.notifier).updateTrip(state);
  }

  Future<void> duplicateTrip() async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    var tripId = const Uuid().v4();
    var memberId = const Uuid().v4();
    var userProfile = ref.read(authControllerProvider).userProfile;
    if (userProfile != null) {
      var items = ref.read(memberControllerProvider).items.where((item) => !item.isShared).toList() +
          state.members.expand((member) => member.items.where((item) => item.isShared && !item.isPrivate)).toList();
      items = items
          .map(
            (e) => e.copyWith(
              futureTransactions: [],
              id: const Uuid().v4(),
              categoryId: const Uuid().v4(),
              memberId: memberId,
              isChecked: false,
            ),
          )
          .toList();
      var tripCopy = state.copyWith(
        name: "${state.name} - copy",
        completedTransactions: [],
        dateFromNull: true,
        dateToNull: true,
        id: tripId,
        isDeleted: false,
        members: [
          Member(
            id: memberId,
            tripId: tripId,
            userProfileId: userProfile.id,
            items: items,
            role: Role.admin.name,
            accepted: true,
            userProfileFirstname: "",
            userProfileLastname: "",
            userProfileEmail: "",
            futureTransactions: [],
            completedTransactionsSent: [],
            completedTransactionsReceived: [],
            userProfileBankAccountNumber: "",
            userProfileIban: "",
          ),
        ],
      );
      state = await apiCaller.createTrip(tripCopy);
      ref.read(tripsControllerProvider.notifier).addTripToList(state);
    }
  }
}

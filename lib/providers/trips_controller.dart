import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/utils/string_utils.dart';
import 'package:uuid/uuid.dart';

import '../model/enum/role.dart';
import '../model/dto/member.dart';
import '../model/dto/trip.dart';
import '../screens/trip/trip_screen.dart';

part 'trips_controller.g.dart';

@Riverpod(keepAlive: true)
class TripsController extends _$TripsController {
  @override
  AsyncValue<List<Trip>> build() {
    if (ref.watch(authControllerProvider).isAuthenticated) loadTrips();
    return const AsyncValue.loading();
  }

  Future<void> loadTrips() async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return (await apiCaller.getTrips()).sorted((x, y) => customOrderSortKey(x.name).compareTo(customOrderSortKey(y.name)));
    });
  }

  Future<void> addTripForUser({required context, required String name, required String userId, DateTime? dateFrom, DateTime? dateTo}) async {
    final ApiCaller apiCaller = ref.read(apiCallerProvider);
    var tripId = const Uuid().v4();
    Trip newTrip = Trip(
      id: tripId,
      name: name.trim().capitalize(),
      dateFrom: dateFrom,
      dateTo: dateTo,
      completedTransactions: [],
      members: [
        Member(
          id: const Uuid().v4(),
          tripId: tripId,
          userProfileId: userId,
          items: [],
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
      isDeleted: false,
    );

    newTrip = await apiCaller.createTrip(newTrip);
    state = AsyncValue.data([newTrip, ...state.value!].sorted((x, y) => customOrderSortKey(x.name).compareTo(customOrderSortKey(y.name))));

    ref.read(tripDetailControllerProvider.notifier).setTrip(newTrip);

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TripScreen(),
      ),
    );
  }

  void updateTrip(Trip trip) {
    log("tripsController - update trip");
    state.whenData((value) {
      var updatedTrips = value.map((e) => e.id == trip.id ? trip : e).toList();
      state = AsyncValue.data(updatedTrips);
    });
  }

  void addTripToList(Trip trip) {
    log("tripsController - addTripToList");
    state.whenData((value) {
      var updatedTrips = (value + [trip]).sorted((x, y) => customOrderSortKey(x.name).compareTo(customOrderSortKey(y.name)));
      state = AsyncValue.data(updatedTrips);
    });
  }
}

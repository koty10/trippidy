import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:uuid/uuid.dart';

import '../model/enum/role.dart';
import '../model/member.dart';
import '../model/trip.dart';
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
      return await apiCaller.getTrips();
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
        ),
      ],
      isDeleted: false,
    );

    newTrip = await apiCaller.createTrip(newTrip);
    state = AsyncValue.data([newTrip, ...state.value!]);

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
    var updatedTrips = state.value!.map((e) => e.id == trip.id ? trip : e).toList();
    log(updatedTrips.where((element) => element.members.any((element2) => !element2.accepted)).length.toString());
    state = AsyncValue.data(updatedTrips);
  }
}

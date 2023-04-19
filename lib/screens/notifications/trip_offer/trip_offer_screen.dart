import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_list_extension.dart';

import '../../../model/trip.dart';
import '../../../providers/auth_controller.dart';
import '../../../providers/trips_controller.dart';
import 'components/trip_offer_tile.dart';

class TripOfferScreen extends ConsumerWidget {
  const TripOfferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //List<Trip> trips = ref.watch(tripsControllerProvider.notifier).getTrips(accepted: false);

    var tripsProvider = ref.watch(tripsControllerProvider);
    var loggedInUser = ref.watch(authControllerProvider);
    List<Trip> trips = tripsProvider.value!.filterTrips(userProfileId: loggedInUser.userProfile!.id, accepted: false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Notifikace'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          return TripOfferTile(trip: trips[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
      ),
    );
  }
}
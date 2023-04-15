import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/trip.dart';
import '../../../providers/trips_controller.dart';
import 'components/trip_offer_tile.dart';

class TripOfferScreen extends ConsumerWidget {
  const TripOfferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Trip> trips = ref.watch(tripsControllerProvider.notifier).getTrips(accepted: false);

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

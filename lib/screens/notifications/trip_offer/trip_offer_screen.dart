import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_list_extension.dart';
import 'package:trippidy/screens/item_lists/components/no_items_animation_widget.dart';

import '../../../model/dto/trip.dart';
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
    //List<Trip> trips = tripsProvider.value!.filterTrips(userProfileId: loggedInUser.userProfile!.id, accepted: false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Notifications"),
      ),
      body: tripsProvider.when(
        data: (data) {
          List<Trip> trips = tripsProvider.value!.filterTrips(userProfileId: loggedInUser.userProfile!.id, accepted: false);
          return trips.isEmpty
              ? RefreshIndicator(
                  onRefresh: ref.read(tripsControllerProvider.notifier).loadTrips,
                  child: const NoItemsAnimationWidget(
                    message: "There are no notifications.",
                    animationFile: "assets/lotties/empty_box.json",
                  ),
                )
              : RefreshIndicator(
                  onRefresh: ref.read(tripsControllerProvider.notifier).loadTrips,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    itemCount: trips.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TripOfferTile(trip: trips[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
                  ),
                );
        },
        error: (error, stackTrace) => const Text("There was a problem to load data"),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

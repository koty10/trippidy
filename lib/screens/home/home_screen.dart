import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_list_extension.dart';
import 'package:trippidy/screens/home/components/notification_button.dart';
import 'package:trippidy/screens/item_lists/components/no_items_animation_widget.dart';

import '../../drawers/home_screen_drawer.dart';
import '../../model/dto/trip.dart';
import '../../providers/auth_controller.dart';
import '../../providers/trips_controller.dart';
import '../add_trip/add_trip_screen.dart';
import 'components/trip_tile.dart';

// Consumer widget and ConsumerStatefullWidget are providing widget reference which allows
// us to access any provider (in my case I will use StateNotifier)
// Refference has 2 important methods:
//    Watch() - watches the state of the provider
//    Read()  - allows us to read and then change the value using its methods which needs
//              to be implemented
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //List<Trip> trips = ref.watch(tripsControllerProvider.notifier).getTrips();

    var tripsProvider = ref.watch(tripsControllerProvider);
    var loggedInUser = ref.watch(authControllerProvider);
    List<Trip> trips = tripsProvider.value!.filterTrips(userProfileId: loggedInUser.userProfile!.id, accepted: true);
    int offersCount = tripsProvider.value!.filterTrips(userProfileId: loggedInUser.userProfile!.id, accepted: false).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trips"),
        actions: [
          IconButton(onPressed: ref.read(tripsControllerProvider.notifier).loadTrips, icon: const Icon(Icons.refresh)),
          NotificationButton(offersCount: offersCount),
        ],
      ),
      drawer: const HomeScreenDrawer(),
      body: RefreshIndicator(
        onRefresh: ref.read(tripsControllerProvider.notifier).loadTrips,
        child: trips.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemCount: trips.length,
                itemBuilder: (BuildContext context, int index) {
                  return TripTile(trip: trips[index]);
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
              )
            : const NoItemsAnimationWidget(
                message: "Start by adding a new trip.",
                animationFile: "assets/lotties/trip_map.json",
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTripScreen(),
            ),
          );
        },
        label: const Text("Add trip"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

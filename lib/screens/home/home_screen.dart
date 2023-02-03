import 'package:trippidy/drawers/drawer_directory.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/screens/home/components/logout_button.dart';

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
    List<Trip> trips = ref.watch(tripsProvider);

    return Scaffold(
      drawer: const DrawerDirectory(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTripScreen(),
            ),
          );
        },
        label: const Text("Přidat výlet"),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Seznam cest'),
        actions: const [LogoutButton()],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              itemBuilder: (BuildContext context, int index) {
                return TripTile(trip: trips[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}

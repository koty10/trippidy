import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/my_list/my_list_screen.dart';
import 'package:trippidy/screens/our_list/our_list_screen.dart';
import 'package:trippidy/screens/trip/components/member_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/screens/trip/components/members_list_view.dart';

class TripScreen extends ConsumerWidget {
  const TripScreen({super.key});

  static const routeName = '/tripScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(currentTrip.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MemberListTile(
                  title: "Můj seznam",
                  currentTrip: currentTrip,
                  target: MyListScreen(
                    currentTrip: currentTrip,
                  ),
                ),
                const SizedBox(height: 16),
                MemberListTile(
                  title: "Společný seznam",
                  currentTrip: currentTrip,
                  target: OurListScreen(
                    currentTrip: currentTrip,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              'Seznamy ostatních členů',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          MembersListView(currentTrip: currentTrip),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Přidat člena"),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

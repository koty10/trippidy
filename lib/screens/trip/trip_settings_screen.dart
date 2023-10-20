import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../../../providers/trip_detail_controller.dart';

class TripSettingsScreen extends ConsumerWidget {
  const TripSettingsScreen({super.key});

  static const routeName = '/tripSettingsScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);
    var format = DateFormat("dd.MM.yyyy");

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(currentTrip.name),
      ),
      body: Column(
        children: [
          // TODO add trip image
          Image.asset(
            "assets/images/trip_illustration.jpg",
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trip name: ${currentTrip.name}"),
                    Text("Owner: ${currentTrip.getOwner().userProfileFirstname} ${currentTrip.getOwner().userProfileLastname}"),
                    if (currentTrip.dateFrom != null && currentTrip.dateTo != null)
                      Text("Date: ${format.format(currentTrip.dateFrom!)} - ${format.format(currentTrip.dateTo!)}"),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          if (currentTrip.getOwner().userProfileId == ref.read(authControllerProvider.notifier).getUserId())
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    foregroundColor: Colors.red,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    ref.read(tripDetailControllerProvider.notifier).deleteTrip();
                    //FIXME i should make those pops in one step
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}

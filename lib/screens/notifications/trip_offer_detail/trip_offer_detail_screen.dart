import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/trip_offer_detail_controller.dart';
import 'package:trippidy/screens/trip/trip_screen.dart';

import '../../../providers/trip_detail_controller.dart';

class TripOfferDetailScreen extends ConsumerWidget {
  const TripOfferDetailScreen({super.key});

  static const routeName = '/tripOfferDetailScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripOfferDetailControllerProvider);
    var format = DateFormat("dd.MM.yyyy");

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(currentTrip.name),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO add trip image
          Image.asset("assets/images/trip_illustration.jpg"),
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
                  "Decline",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    await ref.read(tripOfferDetailControllerProvider.notifier).accept();
                    if (context.mounted) {
                      ref.read(tripDetailControllerProvider.notifier).setTrip(ref.read(tripOfferDetailControllerProvider));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TripScreen(),
                          ),
                          (route) => route.isFirst);
                    }
                  },
                ),
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

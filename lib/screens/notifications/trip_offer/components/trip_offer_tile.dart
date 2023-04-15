import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trippidy/providers/trip_offer_detail_controller.dart';
import 'package:trippidy/screens/notifications/trip_offer_detail/trip_offer_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../../model/trip.dart';

class TripOfferTile extends ConsumerWidget {
  const TripOfferTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var format = DateFormat("dd.MM.yyyy");

    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.lightGreen[400],
      title: Text(
        trip.name,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
      ),
      subtitle:
          Text("Majitel: ${trip.getOwner().userProfileFirstname} ${trip.getOwner().userProfileLastname}\nTermín: ${format.format(trip.dateFrom)} - ${format.format(trip.dateTo)}"),
      isThreeLine: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: trip.members
            .take(3)
            .toList()
            .map(
              (member) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.deepOrange,
                  child: member.userProfileImage != null
                      ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(member.userProfileImage!))
                      : Text(
                          member.userProfileLastname[0],
                          style: const TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            )
            .toList(),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      onTap: () {
        ref.read(tripOfferDetailControllerProvider.notifier).setTrip(trip);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TripOfferDetailScreen(),
          ),
        );
      },
    );
  }
}

import 'package:anti_forgetter/model/trip.dart';
import 'package:anti_forgetter/screens/trip/trip_screen.dart';
import 'package:flutter/material.dart';

class TripTile extends StatelessWidget {
  TripTile({super.key, required this.trip})
      : tripMembers = trip.memberListCollection.length > 3
            ? trip.memberListCollection
                    .map((e) => e.user.name[0])
                    .take(2)
                    .toList() +
                ["..."]
            : trip.memberListCollection
                .map((e) => e.user.name[0])
                .take(3)
                .toList();

  final Trip trip;
  final List<String> tripMembers;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: tripMembers
            .map(
              (member) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    member,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripScreen(
              currentTrip: trip,
            ),
          ),
        );
      },
    );
  }
}

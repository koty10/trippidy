import 'package:trippidy/screens/trip/trip_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/trip.dart';

class TripTile extends StatelessWidget {
  const TripTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    member.userProfileLastname ?? "/",
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

import 'package:trippidy/model/trip.dart';
import 'package:trippidy/screens/trip/trip_screen.dart';
import 'package:flutter/material.dart';

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
      trailing: FutureBuilder<List<String>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: snapshot.data!
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
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
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

  Future<List<String>> getUsers() async {
    return trip.members.length > 3
        ? await Future.wait(trip.members.values
                .map((e) async {
                  return (await e.fetchUser()).name[0];
                })
                .take(2)
                .toList()) +
            ["..."]
        : await Future.wait(trip.members.values.map((e) async => (await e.fetchUser()).name[0]).take(3).toList());
  }
}

import 'package:anti_forgetter/model/trip_model.dart';
import 'package:flutter/material.dart';

import 'components/my_list_tile.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key, required this.currentTrip});

  final TripModel currentTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(currentTrip.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: currentTrip.memberListCollection.length,
              itemBuilder: (BuildContext context, int index) {
                return MyListTile(
                    memberList: currentTrip.memberListCollection[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
            ),
          ),
        ],
      ),
    );
  }
}

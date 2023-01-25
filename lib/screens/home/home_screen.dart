import 'package:anti_forgetter/service/dummy_data_service.dart';
import 'package:flutter/material.dart';

import 'components/trip_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = DummyDataService().getTrips();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seznam cest'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/50x50/?portrait',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
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

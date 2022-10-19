import 'package:anti_forgetter/model/trip_model.dart';
import 'package:flutter/material.dart';

import 'components/record_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      TripModel("Lipno 2022", ["Michal", "David", "Pepa", "Luděk"]),
      TripModel("Itálie 2021", ["Dan"])
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seznam cest"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                return RecordTile(record: records[index]);
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

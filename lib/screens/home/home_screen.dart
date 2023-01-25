import 'package:anti_forgetter/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'components/trip_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  IsarCollection<TripModel>? trips;

  Future<void> loadDataFromLocalDb() async {
    final isar = await Isar.open([TripModelSchema]);
    trips = isar.tripModels;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDataFromLocalDb();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
              itemCount: trips?.countSync() ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return TripTile(trip: trips.getByIndexSync(key));
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

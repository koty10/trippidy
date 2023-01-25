import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/service/dummy_data_service.dart';
import 'package:flutter/material.dart';

class MyListScreen extends StatelessWidget {
  MyListScreen({super.key, required this.currentTrip})
      : myListItems = DummyDataService().getMyListItems(tripId: currentTrip.id);

  final TripModel currentTrip;
  final Map<String, List<ItemModel>> myListItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text("${currentTrip.name} - Můj seznam"),
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
            child: ListView(
              children: myListItems.entries
                  .map(
                    (e) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(e.key),
                      children: e.value
                          .map(
                            (val) => ListTile(
                              title: Text(val.item.value?.name ?? ""),
                              trailing: Checkbox(
                                value: val.checked,
                                onChanged: (value) {}, // TODO save into DB
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

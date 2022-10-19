import 'package:anti_forgetter/model/list_item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/screens/my_list/components/my_list_item_tile.dart';
import 'package:anti_forgetter/service/dummy_data_service.dart';
import 'package:flutter/material.dart';

class MyListScreen extends StatelessWidget {
  MyListScreen({super.key, required this.currentTrip});

  final TripModel currentTrip;
  final Map<String, List<ListItemModel>> myListItems =
      DummyDataService().getMyListItems();

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
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: myListItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Text(myListItems.keys.elementAt(index)),
                    ListView.separated(
                        itemBuilder: (BuildContext context2, int indexInner) {
                          return MyListItemTile(
                              title:
                                  myListItems[myListItems.keys.elementAt(index)]
                                          ?.elementAt(indexInner)
                                          .item
                                          .name ??
                                      "");
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 16),
                        itemCount:
                            myListItems[myListItems.keys.elementAt(index)]
                                    ?.length ??
                                0),
                  ],
                );
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

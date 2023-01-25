import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/model/user_model.dart';
import 'package:anti_forgetter/service/dummy_data_service.dart';
import 'package:flutter/material.dart';

class MembersListScreen extends StatelessWidget {
  MembersListScreen(
      {super.key, required this.currentTrip, required this.currentMember})
      : myListItems = DummyDataService().getListItemsForUser(
            tripId: currentTrip.id, userId: currentMember.id);

  final TripModel currentTrip;
  final UserModel currentMember;
  final Map<String, List<ItemModel>> myListItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text("${currentTrip.name} - ${currentMember.name}"),
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
                              title: Text(val.item.name),
                              trailing:
                                  Checkbox(value: val.checked, onChanged: null),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          )

          // Expanded(
          //   child: ListView.separated(
          //     padding: const EdgeInsets.all(8),
          //     itemCount: myListItems.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Column(
          //         children: [
          //           Text(myListItems.keys.elementAt(index)),
          //           ListView.separated(
          //               itemBuilder: (BuildContext context2, int indexInner) {
          //                 return MyListItemTile(
          //                     title:
          //                         myListItems[myListItems.keys.elementAt(index)]
          //                                 ?.elementAt(indexInner)
          //                                 .item
          //                                 .name ??
          //                             "");
          //               },
          //               separatorBuilder: (BuildContext context, int index) =>
          //                   const SizedBox(height: 16),
          //               itemCount:
          //                   myListItems[myListItems.keys.elementAt(index)]
          //                           ?.length ??
          //                       0),
          //         ],
          //       );
          //     },
          //     separatorBuilder: (BuildContext context, int index) =>
          //         const SizedBox(height: 16),
          //   ),
          // ),
        ],
      ),
    );
  }
}

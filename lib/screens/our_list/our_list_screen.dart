import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';

class OurListScreen extends StatelessWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
    required this.myListItems,
  });

  final Trip currentTrip;
  final Map<String, List<Item>> myListItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - Společný seznam"),
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
                              title: Text(val.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (val.userId !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        radius: 12,
                                        child: Text(val.userId),
                                      ),
                                    ),
                                  Checkbox(
                                      value: val.checked,
                                      onChanged: val.userId ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? ((value) {})
                                          : null),
                                ],
                              ), // TODO nekde musim mit ulozeny id prihlaseneho usera
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

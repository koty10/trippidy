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
        leading: const BackButton(color: Colors.white),
        title: Text("${currentTrip.name} - Společný seznam"),
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
                              title: Text(val.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (val.userId != 1)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        radius: 12,
                                        child: Text(val.userId.toString()),
                                      ),
                                    ),
                                  Checkbox(
                                      value: val.checked,
                                      onChanged: val.userId == 1
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

import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class MembersListScreen extends StatelessWidget {
  const MembersListScreen({
    super.key,
    required this.currentTrip,
    required this.currentUser,
  });

  final Trip currentTrip;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - ${currentUser.name}"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: getListItemsForUser(userId: currentUser.documentId)
                  .entries
                  .map(
                    (e) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(e.key),
                      children: e.value
                          .map(
                            (val) => ListTile(
                              title: Text(val.name),
                              trailing: Checkbox(value: val.checked, onChanged: null),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Item>> getListItemsForUser({required String userId}) {
    var member = currentTrip.members[userId];
    if (member == null) return {};
    var tmp = member.items.values.toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null ? dict[element.category]?.add(element) : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }
}

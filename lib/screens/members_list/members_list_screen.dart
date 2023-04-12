import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';

class MembersListScreen extends StatelessWidget {
  const MembersListScreen({
    super.key,
    required this.currentTrip,
    required this.currentMember,
  });

  final Trip currentTrip;
  final Member currentMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - ${currentMember.userProfileLastname}"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: getListItemsForUser(userId: currentMember.id) //FIXME - null
                  .entries
                  .map(
                    (e) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(e.key),
                      children: e.value
                          .map(
                            (val) => ListTile(
                              title: Text(val.name),
                              trailing: Checkbox(value: val.isChecked, onChanged: null),
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
    var member = currentTrip.members.firstWhere((element) => element.id == userId);
    //if (member == null) return {};
    var tmp = member.items;

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

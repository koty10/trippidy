import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

class MembersListScreen extends ConsumerWidget {
  const MembersListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(memberControllerProvider);
    final currentTrip = ref.watch(tripDetailControllerProvider);
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
              children: getListItemsForUser(userId: currentMember.id, currentTrip: currentTrip) //FIXME - null
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

  Map<String, List<Item>> getListItemsForUser({required String userId, required Trip currentTrip}) {
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';

import '../../model/member.dart';

class OurListScreen extends ConsumerWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, ref) {
    Member member = ref.watch(memberControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - společný seznam"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: getOurListItems(member)
                  .entries
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
                                  if (val.memberId != ref.read(memberControllerProvider).id)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        radius: 12,
                                        child: Text(val.memberId.toString()),
                                      ),
                                    ),
                                  Checkbox(
                                    fillColor: MaterialStateProperty.all(Colors.green),
                                    value: val.isChecked,
                                    onChanged: val.memberId == ref.read(memberControllerProvider).id
                                        ? (value) {
                                            val.isChecked = value ?? false;
                                            ref.read(memberControllerProvider.notifier).updateItem(context, currentTrip.id, val); // FIXME - null
                                          }
                                        : null,
                                  ),
                                ],
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

  Map<String, List<Item>> getOurListItems(Member member) {
    var tmp = ((currentTrip.members).where((m) => m.userProfileId != member.userProfileId).toList() + [member]) // FIXME i have to get userId somehow
        .expand((element2) => element2.items)
        .where((element3) => element3.isShared)
        .toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

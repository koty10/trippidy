import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';

import '../../model/member.dart';
import '../../providers/member_provider.dart';

class OurListScreen extends ConsumerWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, ref) {
    Member member = ref.watch(memberProvider);

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
                                  if (val.memberId != ref.read(memberProvider).id) // FIXME i have to get memberId somehow
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
                                    onChanged: val.memberId == ref.read(memberProvider).id // FIXME i have to get memberId somehow
                                        ? (value) {
                                            val.isChecked = value ?? false;
                                            ref.read(memberProvider.notifier).updateItem(context, currentTrip.id, val); // FIXME - null
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
    var tmp =
        ((currentTrip.members).where((element) => element.userProfileId != member.userProfileId).toList() + [member]) // FIXME i have to get userId somehow
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

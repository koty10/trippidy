import 'package:firebase_auth/firebase_auth.dart';
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
                                  if (val.userId != FirebaseAuth.instance.currentUser!.uid)
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
                                      onChanged: val.userId == FirebaseAuth.instance.currentUser!.uid
                                          ? (value) {
                                              val.checked = value ?? false;
                                              ref.read(memberProvider.notifier).updateItem(context, currentTrip.id, val);
                                            }
                                          : null),
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
    var tmp = ((currentTrip.members.values.toList()).where((element) => element.userId != FirebaseAuth.instance.currentUser!.uid).toList() + [member])
        .expand((element2) => element2.items.values)
        .where((element3) => element3.shared)
        .toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null ? dict[element.category]?.add(element) : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }
}

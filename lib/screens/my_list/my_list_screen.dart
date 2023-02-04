import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_provider.dart';
import 'package:trippidy/screens/add_item/add_item_screen.dart';

import '../../model/item.dart';

class MyListScreen extends ConsumerWidget {
  const MyListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, ref) {
    Member member = ref.watch(memberProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Přidat položku"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(
                currentTrip: currentTrip.id,
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - Můj seznam"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: getMyListItems(member)
                  .entries
                  .map(
                    (e) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(e.key),
                      children: e.value
                          .map(
                            (val) => ListTile(
                              title: Text(val.name),
                              trailing: Checkbox(
                                value: val.checked,
                                onChanged: (value) {
                                  val.checked = value ?? false;
                                  ref
                                      .read(memberProvider.notifier)
                                      .updateItem(context, currentTrip.id, val);
                                }, // TODO save into DB
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

  Map<String, List<Item>> getMyListItems(Member member) {
    var tmp = member.items.values;

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null
          ? dict[element.category]?.add(element)
          : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }
}

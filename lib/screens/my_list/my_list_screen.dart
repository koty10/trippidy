import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
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
    Member member = ref.watch(memberControllerProvider);
    var items = getMyListItems(member).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - můj seznam"),
      ),
      body: items.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/lotties/empty_box.json',
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Center(child: Text('Nemáte zatím žádné položky.')),
              ],
            )
          : ListView(
              //padding: const EdgeInsets.all(8),
              children: items
                  .map(
                    (e) => Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(e.key),
                        children: e.value
                            .map(
                              (val) => ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddItemScreen(
                                        currentTrip: currentTrip,
                                        item: val,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  val.name,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (val.price != 0)
                                      Text(
                                        "${val.price} Kč",
                                        style: context.txtTheme.bodySmall,
                                      ),
                                    if (val.isPrivate)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8, left: 16),
                                        child: Icon(Icons.visibility_off),
                                      ),
                                    if (val.isShared)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8, left: 16),
                                        child: Icon(Icons.groups),
                                      ),
                                    Checkbox(
                                      //fillColor: MaterialStateProperty.all(Colors.green),
                                      value: val.isChecked,
                                      onChanged: (value) {
                                        val.isChecked = value ?? false;
                                        ref.read(memberControllerProvider.notifier).updateItem(currentTrip.id, val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Přidat položku"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(
                currentTrip: currentTrip,
                private: false,
                shared: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, List<Item>> getMyListItems(Member member) {
    var tmp = member.items;

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

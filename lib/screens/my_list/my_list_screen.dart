import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/screens/add_item/add_item_screen.dart';

import '../../model/dto/item.dart';

class MyListScreen extends ConsumerStatefulWidget {
  const MyListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  ConsumerState<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends ConsumerState<MyListScreen> {
  bool expandAll = true;

  @override
  Widget build(BuildContext context) {
    log("rebuild $expandAll");
    Member member = ref.watch(memberControllerProvider);
    var items = getMyListItems(member).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${widget.currentTrip.name} - můj seznam"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                expandAll = !expandAll;
              });
            },
            icon: Icon(
              expandAll ? Icons.visibility : Icons.visibility_off,
            ),
          )
        ],
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
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (e) => Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        key: GlobalKey(),
                        initiallyExpanded: expandAll,
                        backgroundColor: e.key % 2 == 0
                            ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2)
                            : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                        collapsedBackgroundColor: e.key % 2 == 0
                            ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2)
                            : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                        leading: const Icon(Icons.list),
                        title: Text(e.value.key),
                        children: e.value.value
                            .map(
                              (val) => ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddItemScreen(
                                        currentTrip: widget.currentTrip,
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
                                    if (val.price != Decimal.zero)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child: Text(
                                          "${val.price} Kč",
                                          style: context.txtTheme.bodySmall,
                                        ),
                                      ),
                                    if (val.isPrivate)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Icon(Icons.visibility_off),
                                      ),
                                    if (val.isShared)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Icon(Icons.groups),
                                      ),
                                    Checkbox(
                                      //visualDensity: VisualDensity.compact,
                                      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      //visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

                                      //fillColor: MaterialStateProperty.all(Colors.green),
                                      value: val.isChecked,
                                      onChanged: (value) {
                                        val.isChecked = value ?? false;
                                        ref.read(memberControllerProvider.notifier).updateItem(widget.currentTrip.id, val);
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
                currentTrip: widget.currentTrip,
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

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/member_extension.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/screens/add_item/add_item_screen.dart';
import 'package:trippidy/screens/item_lists/components/all_items_widget.dart';
import 'package:trippidy/screens/item_lists/components/no_items_animation_widget.dart';

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
    var items = member.getMyListItems().entries;

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
          ? const NoItemsAnimationWidget(
              message: "Nemáte zatím žádné položky.",
            )
          : AllItemsWidget(
              items: items,
              expandAll: expandAll,
              currentTrip: widget.currentTrip,
              onTapCallback: () => {},
              onChangedCallback: (item, value) => {
                item.isChecked = value,
                ref.read(memberControllerProvider.notifier).updateItem(
                      widget.currentTrip.id,
                      item,
                    ),
              },
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
}

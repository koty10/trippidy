import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/member_extension.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/screens/add_item/add_item_screen.dart';
import 'package:trippidy/screens/item_lists/components/all_items_widget.dart';
import 'package:trippidy/screens/item_lists/components/no_items_animation_widget.dart';

class MyListScreen extends ConsumerWidget {
  const MyListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Member member = ref.watch(memberControllerProvider);
    var items = member.getMyListItems().entries;
    var expandAll = ref.watch(expandAllCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - můj seznam"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
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
              currentTrip: currentTrip,
              onTapCallback: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(
                      currentTrip: currentTrip,
                      item: item,
                    ),
                  ),
                );
              },
              onChangedCallback: (item, value) {
                item.isChecked = value;
                ref.read(memberControllerProvider.notifier).updateItem(
                      currentTrip.id,
                      item,
                    );
              },
              currentMember: ref.read(memberControllerProvider),
              showAvatars: false,
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
}

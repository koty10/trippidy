import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/member_extension.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';
import 'package:trippidy/providers/suggested_items_controller.dart';
import 'package:trippidy/screens/add_item/add_item_screen.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';
import 'package:trippidy/screens/item_lists/components/no_items_animation_widget.dart';
import 'package:trippidy/screens/item_lists/components/suggested_items_bottom_sheet.dart';

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
    var showTabs = ref.watch(showTabsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentTrip.name),
            Text(
              "My list",
              style: context.txtTheme.titleSmall,
            )
          ],
        ),
        actions: [
          showTabs
              ? IconButton(
                  onPressed: () {
                    //ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
                    ref.read(suggestedItemsControllerProvider.notifier).suggestItems(false);
                    SuggestedItemsBottomSheet.suggestedItemsBottomSheet(context, false);
                  },
                  icon: const Icon(Icons.auto_awesome),
                )
              : IconButton(
                  onPressed: () {
                    ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
                  },
                  icon: Icon(
                    expandAll ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
          IconButton(
            onPressed: () {
              if (showTabs) {
                ref.read(selectedCategoryProvider.notifier).state = "";
              } else {
                ref.read(selectedCategoryProvider.notifier).state = items.isNotEmpty ? items.first.key : "Other";
              }
              ref.read(showTabsProvider.notifier).state = !showTabs;
            },
            icon: Icon(
              showTabs ? Icons.grid_view : Icons.view_list,
            ),
          )
        ],
      ),
      body: items.isEmpty
          ? const NoItemsAnimationWidget(
              message: "You have no items.",
            )
          : ItemsWrapperWidget(
              categoriesWithItems: items,
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
        label: const Text("Add item"),
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

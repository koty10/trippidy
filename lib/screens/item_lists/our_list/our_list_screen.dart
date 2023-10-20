import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';
import 'package:trippidy/providers/suggested_items_controller.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';
import 'package:trippidy/screens/item_lists/components/suggested_items_bottom_sheet.dart';

import '../../../model/dto/member.dart';
import '../../add_item/add_item_screen.dart';
import '../components/no_items_animation_widget.dart';

class OurListScreen extends ConsumerWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Member member = ref.watch(memberControllerProvider);
    var items = currentTrip.getOurListItems(loggedUserMember: member).entries;
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
              "Společný seznam",
              style: context.txtTheme.titleSmall,
            )
          ],
        ),
        actions: [
          showTabs
              ? IconButton(
                  onPressed: () {
                    //ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
                    ref.read(suggestedItemsControllerProvider.notifier).suggestItems(true);
                    SuggestedItemsBottomSheet.suggestedItemsBottomSheet(context, true);
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
                ref.read(selectedCategoryProvider.notifier).state = items.first.key;
              }
              ref.read(showTabsProvider.notifier).state = !ref.read(showTabsProvider.notifier).state;
            },
            icon: Icon(
              showTabs ? Icons.grid_view : Icons.view_list,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: items.isEmpty
                  ? const NoItemsAnimationWidget(
                      message: "Nemáte žádné společné položky.",
                    )
                  : ItemsWrapperWidget(
                      categoriesWithItems: items,
                      currentTrip: currentTrip,
                      currentMember: ref.read(memberControllerProvider),
                      showAvatars: true,
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
                    ))
        ],
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
                shared: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

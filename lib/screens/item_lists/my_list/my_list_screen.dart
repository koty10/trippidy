import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/components/grid_view_shimmer.dart';
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
        title: Text("${currentTrip.name} - můj seznam"),
        actions: [
          showTabs
              ? IconButton(
                  onPressed: () {
                    //ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
                    ref.read(suggestedItemsControllerProvider.notifier).suggestItems();
                    _showBottomSheet(context);
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
              message: "Nemáte zatím žádné položky.",
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, child) {
              final items = ref.watch(suggestedItemsControllerProvider);

              return items.when(
                error: (o, s) => Container(),
                loading: () => const GridViewShimmer(),
                data: (List<String> items) => Container(
                  //constraints: const BoxConstraints(maxHeight: 500),
                  padding: const EdgeInsets.all(16.0),
                  height: (items.length / 2).ceil() * 80 + 16, // You might want to adjust the height to your need
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(), // This disables scrolling
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 2, // Adjust aspect ratio to control the size of the tiles
                      mainAxisSpacing: 16.0, // Vertical spacing
                      crossAxisSpacing: 16.0, // Horizontal spacing
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: InkWell(
                          onTap: () {
                            log('Adding generated item ${items.elementAt(index)} to the item list');

                            ref.read(memberControllerProvider.notifier).addItem(
                              name: items.elementAt(index),
                              category: ref.read(selectedCategoryProvider),
                              shared: false,
                              private: false,
                              price: Decimal.zero,
                              futureTransactions: [],
                            );

                            ref.read(suggestedItemsControllerProvider.notifier).removeItem(items.elementAt(index));
                            if (items.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          child: Card(
                            color: context.colorScheme.secondaryContainer,
                            child: Center(
                              child: Text(items.elementAt(index)),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: items.length,
                  ),
                ),
              );
            },
          );
        });
  }
}

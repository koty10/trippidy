// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/screens/item_lists/components/item_list_tile.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';

class ItemsByCategoryWidget extends ConsumerWidget {
  final Iterable<MapEntry<String, List<Item>>> categoriesWithItems;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;

  const ItemsByCategoryWidget({
    super.key,
    required this.categoriesWithItems,
    required this.currentTrip,
    this.onTapCallback,
    this.onChangedCallback,
    required this.currentMember,
    required this.showAvatars,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: categoriesWithItems.length,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              ref.read(selectedCategoryProvider.notifier).state = categoriesWithItems.elementAt(value).key;
            },
            isScrollable: true,
            tabs: categoriesWithItems.map((category) {
              return Tab(text: category.key);
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: categoriesWithItems.map((category) {
                return CategoryItemsView(
                  items: category.value,
                  currentMember: currentMember,
                  currentTrip: currentTrip,
                  showAvatars: showAvatars,
                  onChangedCallback: onChangedCallback,
                  onTapCallback: onTapCallback,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItemsView extends StatelessWidget {
  final List<Item> items;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;

  const CategoryItemsView({
    super.key,
    required this.items,
    required this.currentTrip,
    this.onTapCallback,
    this.onChangedCallback,
    required this.currentMember,
    required this.showAvatars,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemListTile(
          item: item,
          currentMember: currentMember,
          currentTrip: currentTrip,
          showAvatars: showAvatars,
          onChangedCallback: onChangedCallback,
          onTapCallback: onTapCallback,
        );
      },
    );
  }
}

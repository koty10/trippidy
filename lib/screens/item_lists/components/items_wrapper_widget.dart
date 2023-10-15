// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';
import 'package:trippidy/screens/item_lists/components/all_items_widget.dart';
import 'package:trippidy/screens/item_lists/components/items_by_category_widget.dart';

typedef TrippidyItemFunctionType = Function(Item item);
typedef TrippidyItemBoolFunctionType = Function(Item item, bool value);

class ItemsWrapperWidget extends ConsumerWidget {
  final Iterable<MapEntry<String, List<Item>>> categoriesWithItems;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;

  const ItemsWrapperWidget({
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
    var showTabs = ref.watch(showTabsProvider);
    return showTabs
        ? ItemsByCategoryWidget(
            categoriesWithItems: categoriesWithItems,
            currentTrip: currentTrip,
            onTapCallback: onTapCallback,
            onChangedCallback: onChangedCallback,
            currentMember: currentMember,
            showAvatars: showAvatars,
          )
        : AllItemsWidget(
            categoriesWithItems: categoriesWithItems,
            currentTrip: currentTrip,
            onTapCallback: onTapCallback,
            onChangedCallback: onChangedCallback,
            currentMember: currentMember,
            showAvatars: showAvatars,
          );
  }
}

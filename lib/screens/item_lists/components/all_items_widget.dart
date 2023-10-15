import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/screens/item_lists/components/item_list_tile.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';

class AllItemsWidget extends ConsumerWidget {
  final Iterable<MapEntry<String, List<Item>>> categoriesWithItems;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;
  const AllItemsWidget({
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
    var expandAll = ref.watch(expandAllCategoriesProvider);
    return ListView(
      children: categoriesWithItems
          .toList()
          .asMap()
          .entries
          .map(
            (e) => Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                key: GlobalKey(),
                initiallyExpanded: expandAll,
                backgroundColor:
                    e.key % 2 == 0 ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2) : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                collapsedBackgroundColor:
                    e.key % 2 == 0 ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2) : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                leading: const Icon(Icons.list),
                title: Text(e.value.key),
                children: e.value.value
                    .map(
                      (item) => ItemListTile(
                        item: item,
                        currentMember: currentMember,
                        currentTrip: currentTrip,
                        showAvatars: showAvatars,
                        onChangedCallback: onChangedCallback,
                        onTapCallback: onTapCallback,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}

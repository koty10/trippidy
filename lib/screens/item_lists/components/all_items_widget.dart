import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';

typedef TrippidyItemFunctionType = Function(Item item);
typedef TrippidyItemBoolFunctionType = Function(Item item, bool value);

class AllItemsWidget extends ConsumerWidget {
  final Iterable<MapEntry<String, List<Item>>> items;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;
  const AllItemsWidget({
    super.key,
    required this.items,
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
                  backgroundColor:
                      e.key % 2 == 0 ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2) : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                  collapsedBackgroundColor:
                      e.key % 2 == 0 ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2) : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                  leading: const Icon(Icons.list),
                  title: Text(e.value.key),
                  children: e.value.value
                      .map(
                        (item) => ListTile(
                          onTap: (item.memberId == currentMember.id && onTapCallback != null) ? () => onTapCallback!(item) : null,
                          title: Text(item.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item.price != Decimal.zero)
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    "${item.price} Kč",
                                    style: context.txtTheme.bodySmall,
                                  ),
                                ),
                              if (item.isPrivate)
                                const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.visibility_off),
                                ),
                              if (!showAvatars && item.isShared)
                                const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.groups),
                                ),
                              if (showAvatars && item.memberId != currentMember.id)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8, left: 16),
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(currentTrip.members.firstWhere((element) => element.id == item.memberId).userProfileImage!),
                                    ),
                                  ),
                                ),
                              Checkbox(
                                //visualDensity: VisualDensity.compact,
                                //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

                                //fillColor: MaterialStateProperty.all(Colors.green),
                                value: item.isChecked,
                                onChanged: (item.memberId == currentMember.id && onChangedCallback != null)
                                    ? (value) {
                                        onChangedCallback!(item, value ?? false);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList());
  }
}

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/trip.dart';

typedef TrippidyParameterlessFunctionType = Function();
typedef TrippidyItemBoolFunctionType = Function(Item item, bool value);

class AllItemsWidget extends StatelessWidget {
  final Iterable<MapEntry<String, List<Item>>> items;
  final bool expandAll;
  final Trip currentTrip;
  final TrippidyParameterlessFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  const AllItemsWidget(
      {super.key, required this.items, required this.expandAll, required this.currentTrip, required this.onTapCallback, required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
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
                          onTap: onTapCallback,
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
                              if (item.isShared)
                                const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.groups),
                                ),
                              Checkbox(
                                //visualDensity: VisualDensity.compact,
                                //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

                                //fillColor: MaterialStateProperty.all(Colors.green),
                                value: item.isChecked,
                                onChanged: onChangedCallback != null
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

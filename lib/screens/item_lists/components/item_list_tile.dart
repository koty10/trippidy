// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';

class ItemListTile extends ConsumerWidget {
  final Item item;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;
  const ItemListTile({
    super.key,
    required this.item,
    required this.currentTrip,
    this.onTapCallback,
    this.onChangedCallback,
    required this.currentMember,
    required this.showAvatars,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
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
                  child: Image.network(
                    currentTrip.members.firstWhere((element) => element.id == item.memberId).userProfileImage!.convertToImageProxy(),
                  ),
                ),
              ),
            ),
          Checkbox(
            value: item.isChecked,
            onChanged: (item.memberId == currentMember.id && onChangedCallback != null)
                ? (value) {
                    onChangedCallback!(
                      item,
                      value ?? false,
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

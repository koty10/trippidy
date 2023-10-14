import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

import '../components/no_items_animation_widget.dart';

class MembersListScreen extends ConsumerStatefulWidget {
  const MembersListScreen({
    super.key,
  });

  @override
  ConsumerState<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends ConsumerState<MembersListScreen> {
  bool expandAll = true;

  @override
  Widget build(BuildContext context) {
    final currentMember = ref.watch(memberControllerProvider);
    final currentTrip = ref.watch(tripDetailControllerProvider);
    var items = currentTrip.getListItemsForUser(userId: currentMember.id).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - ${currentMember.userProfileFirstname} ${currentMember.userProfileLastname}"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                expandAll = !expandAll;
              });
            },
            icon: Icon(
              expandAll ? Icons.visibility : Icons.visibility_off,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: items.isEmpty
                ? const NoItemsAnimationWidget(
                    message: "Uživatel nemá žádné veřejné položky.",
                  )
                : ListView(
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
                              backgroundColor: e.key % 2 == 0
                                  ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2)
                                  : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                              collapsedBackgroundColor: e.key % 2 == 0
                                  ? Color.lerp(context.colorScheme.surface, Colors.black, 0.2)
                                  : Color.lerp(context.colorScheme.surface, Colors.black, 0.0),
                              leading: const Icon(Icons.list),
                              title: Text(e.value.key),
                              children: e.value.value
                                  .map(
                                    (val) => ListTile(
                                      title: Text(val.name),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (val.price != Decimal.zero) Text("${val.price} Kč"),
                                          if (val.isShared)
                                            const Padding(
                                              padding: EdgeInsets.only(right: 8, left: 16),
                                              child: Icon(Icons.groups),
                                            ),
                                          Checkbox(value: val.isChecked, onChanged: null),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
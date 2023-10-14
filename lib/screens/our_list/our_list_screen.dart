import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';

import '../../model/dto/member.dart';
import '../add_item/add_item_screen.dart';

class OurListScreen extends ConsumerStatefulWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  ConsumerState<OurListScreen> createState() => _OurListScreenState();
}

class _OurListScreenState extends ConsumerState<OurListScreen> {
  bool expandAll = true;

  @override
  Widget build(BuildContext context) {
    Member member = ref.watch(memberControllerProvider);
    var items = widget.currentTrip.getOurListItems(loggedUserMember: member).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${widget.currentTrip.name} - společný seznam"),
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/lotties/empty_box.json',
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Center(child: Text('Nemáte žádné společné položky.')),
                    ],
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
                                      onTap: val.memberId == ref.read(memberControllerProvider).id
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddItemScreen(
                                                    currentTrip: widget.currentTrip,
                                                    item: val,
                                                  ),
                                                ),
                                              );
                                            }
                                          : null,
                                      title: Text(val.name),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (val.price != Decimal.zero) Text("${val.price} Kč"),
                                          if (val.memberId != ref.read(memberControllerProvider).id)
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8, left: 16),
                                              child: CircleAvatar(
                                                radius: 12,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network(
                                                      widget.currentTrip.members.firstWhere((element) => element.id == val.memberId).userProfileImage!),
                                                ),
                                              ),
                                            ),
                                          Checkbox(
                                            //fillColor: val.memberId == ref.read(memberControllerProvider).id ? MaterialStateProperty.all(Colors.green) : null,
                                            value: val.isChecked,
                                            onChanged: val.memberId == ref.read(memberControllerProvider).id
                                                ? (value) {
                                                    val.isChecked = value ?? false;
                                                    ref.read(memberControllerProvider.notifier).updateItem(widget.currentTrip.id, val);
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
                        .toList(),
                  ),
          )
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
                currentTrip: widget.currentTrip,
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

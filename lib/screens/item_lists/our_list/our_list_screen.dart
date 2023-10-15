import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/screens/item_lists/components/all_items_widget.dart';

import '../../../model/dto/member.dart';
import '../../add_item/add_item_screen.dart';
import '../components/no_items_animation_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    Member member = ref.watch(memberControllerProvider);
    var items = widget.currentTrip.getOurListItems(loggedUserMember: member).entries;
    var expandAll = ref.watch(expandAllCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${widget.currentTrip.name} - společný seznam"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(expandAllCategoriesProvider.notifier).state = !ref.read(expandAllCategoriesProvider.notifier).state;
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
                      message: "Nemáte žádné společné položky.",
                    )
                  : AllItemsWidget(
                      items: items,
                      currentTrip: widget.currentTrip,
                      currentMember: ref.read(memberControllerProvider),
                      showAvatars: true,
                      onTapCallback: (item) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddItemScreen(
                              currentTrip: widget.currentTrip,
                              item: item,
                            ),
                          ),
                        );
                      },
                      onChangedCallback: (item, value) {
                        item.isChecked = value;
                        ref.read(memberControllerProvider.notifier).updateItem(
                              widget.currentTrip.id,
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

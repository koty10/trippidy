import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/item_lists/components/all_items_widget.dart';

import '../components/no_items_animation_widget.dart';

class MembersListScreen extends ConsumerStatefulWidget {
  const MembersListScreen({
    super.key,
  });

  @override
  ConsumerState<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends ConsumerState<MembersListScreen> {
  @override
  Widget build(BuildContext context) {
    final currentMember = ref.watch(memberControllerProvider);
    final currentTrip = ref.watch(tripDetailControllerProvider);
    var items = currentTrip.getListItemsForUser(userId: currentMember.id).entries;
    var expandAll = ref.watch(expandAllCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - ${currentMember.userProfileFirstname} ${currentMember.userProfileLastname}"),
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
                    message: "Uživatel nemá žádné veřejné položky.",
                  )
                : AllItemsWidget(
                    items: items,
                    currentTrip: currentTrip,
                    currentMember: currentMember,
                    showAvatars: false,
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';

import '../components/no_items_animation_widget.dart';

class MembersListScreen extends ConsumerWidget {
  const MembersListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(memberControllerProvider);
    final currentTrip = ref.watch(tripDetailControllerProvider);
    var items = currentTrip.getListItemsForUser(userId: currentMember.id).entries;
    var expandAll = ref.watch(expandAllCategoriesProvider);
    var showTabs = ref.watch(showTabsProvider);

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
          ),
          IconButton(
            onPressed: () {
              ref.read(showTabsProvider.notifier).state = !ref.read(showTabsProvider.notifier).state;
            },
            icon: Icon(
              showTabs ? Icons.grid_view : Icons.view_list,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const NoItemsAnimationWidget(
                    message: "Uživatel nemá žádné veřejné položky.",
                  )
                : ItemsWrapperWidget(
                    categoriesWithItems: items,
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

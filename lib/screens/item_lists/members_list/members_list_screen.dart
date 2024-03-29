import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/expand_all_categories_provider.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentTrip.name,
            ),
            Text(
              "${currentMember.userProfileFirstname} ${currentMember.userProfileLastname}",
              style: context.txtTheme.titleSmall,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: ref.read(tripDetailControllerProvider.notifier).refreshTrip, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              if (showTabs) {
                ref.read(selectedCategoryProvider.notifier).state = "";
              } else {
                ref.read(selectedCategoryProvider.notifier).state = items.first.key;
              }
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
                ? RefreshIndicator(
                    onRefresh: ref.read(tripDetailControllerProvider.notifier).refreshTrip,
                    child: const NoItemsAnimationWidget(
                      message: "User has no public items.",
                      animationFile: "assets/lotties/empty_box.json",
                    ),
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

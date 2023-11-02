// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/item_lists/components/item_list_tile.dart';
import 'package:trippidy/screens/item_lists/components/items_wrapper_widget.dart';

class ItemsByCategoryWidget extends ConsumerStatefulWidget {
  final Iterable<MapEntry<String, List<Item>>> categoriesWithItems;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;

  const ItemsByCategoryWidget({
    super.key,
    required this.categoriesWithItems,
    required this.currentTrip,
    this.onTapCallback,
    this.onChangedCallback,
    required this.currentMember,
    required this.showAvatars,
  });

  @override
  ConsumerState<ItemsByCategoryWidget> createState() => _ItemsByCategoryWidgetState();
}

class _ItemsByCategoryWidgetState extends ConsumerState<ItemsByCategoryWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.categoriesWithItems.length,
    );

    _tabController.addListener(() {
      final value = _tabController.index;
      ref.read(selectedCategoryProvider.notifier).state = widget.categoriesWithItems.elementAt(value).key;
    });
  }

  void _reinitTabController() {
    var previousTabName = ref.read(selectedCategoryProvider.notifier).state;
    int currentTabIndexFromPreviousTabName = widget.categoriesWithItems.toList().indexWhere((entry) => entry.key == previousTabName);

    // Dispose old controller without triggering any listeners
    _tabController.dispose();

    // Create new controller with new length
    _tabController = TabController(
      vsync: this,
      length: widget.categoriesWithItems.length,
    );

    if (currentTabIndexFromPreviousTabName < _tabController.length && currentTabIndexFromPreviousTabName >= 0) {
      _tabController.index = currentTabIndexFromPreviousTabName;
    }

    // Add post frame callback to update state after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.addListener(() {
        final value = _tabController.index;
        ref.read(selectedCategoryProvider.notifier).state = widget.categoriesWithItems.elementAt(value).key;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _reinitTabController();

    log(ref.watch(selectedCategoryProvider));
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          onTap: (value) {
            ref.read(selectedCategoryProvider.notifier).state = widget.categoriesWithItems.elementAt(value).key;
          },
          isScrollable: true,
          tabs: widget.categoriesWithItems.map((category) {
            return Tab(text: category.key);
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.categoriesWithItems.map((category) {
              return RefreshIndicator(
                onRefresh: () => ref.read(tripDetailControllerProvider.notifier).refreshTrip(),
                child: CategoryItemsView(
                  items: category.value,
                  currentMember: widget.currentMember,
                  currentTrip: widget.currentTrip,
                  showAvatars: widget.showAvatars,
                  onChangedCallback: widget.onChangedCallback,
                  onTapCallback: widget.onTapCallback,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CategoryItemsView extends StatelessWidget {
  final List<Item> items;
  final Trip currentTrip;
  final TrippidyItemFunctionType? onTapCallback;
  final TrippidyItemBoolFunctionType? onChangedCallback;
  final Member currentMember;
  final bool showAvatars;

  const CategoryItemsView({
    super.key,
    required this.items,
    required this.currentTrip,
    this.onTapCallback,
    this.onChangedCallback,
    required this.currentMember,
    required this.showAvatars,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemListTile(
          item: item,
          currentMember: currentMember,
          currentTrip: currentTrip,
          showAvatars: showAvatars,
          onChangedCallback: onChangedCallback,
          onTapCallback: onTapCallback,
        );
      },
    );
  }
}

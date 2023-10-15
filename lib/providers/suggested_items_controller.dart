import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';
import 'package:trippidy/model/dto/requests/suggestion_request.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

part 'suggested_items_controller.g.dart';

@Riverpod(keepAlive: true)
class SuggestedItemsController extends _$SuggestedItemsController {
  @override
  AsyncValue<List<String>> build() {
    return const AsyncValue.loading();
  }

  Future<void> removeItem(String name) async {
    //state = state.where((element) => element != name).toList();
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (state.hasValue) {
        return state.value!.where((element) => element != name).toList();
      } else {
        return [];
      }
    });
  }

  Future<void> suggestItems() async {
    log("generating");
    var tripName = ref.read(tripDetailControllerProvider).name;
    var itemsCategory = ref.read(selectedCategoryProvider);
    var alreadyPackedItems = ref.read(memberControllerProvider).items.where((element) => element.categoryName == itemsCategory).map((e) => e.name).toList();

    var suggestedItems = ref.read(apiCallerProvider).suggestItems(
          SuggestionRequest(
            tripName: tripName,
            itemsCategory: itemsCategory,
            alreadyPackedItems: alreadyPackedItems,
          ),
        );

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return (await suggestedItems).suggestedItems;
    });
    //state = suggestedItems.suggestedItems;
  }
}

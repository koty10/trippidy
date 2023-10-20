import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/components/grid_view_shimmer.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/suggested_items_controller.dart';

class SuggestedItemsBottomSheet {
  static void suggestedItemsBottomSheet(BuildContext context, bool shared) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, child) {
              final items = ref.watch(suggestedItemsControllerProvider);

              return items.when(
                error: (o, s) => const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text("Nepodařilo se načíst položky"),
                  ),
                ),
                loading: () => const GridViewShimmer(),
                data: (List<String> items) => Container(
                  //constraints: const BoxConstraints(maxHeight: 500),
                  padding: const EdgeInsets.all(16.0),
                  height: (items.length / 2).ceil() * 80 + 16,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 2,
                      mainAxisSpacing: 16.0, // Vertical spacing
                      crossAxisSpacing: 16.0, // Horizontal spacing
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: InkWell(
                          onTap: () {
                            log('Adding generated item ${items.elementAt(index)} to the item list');

                            ref.read(memberControllerProvider.notifier).addItem(
                              name: items.elementAt(index),
                              category: ref.read(selectedCategoryProvider),
                              shared: shared,
                              private: false,
                              price: Decimal.zero,
                              futureTransactions: [],
                            );

                            ref.read(suggestedItemsControllerProvider.notifier).removeItem(items.elementAt(index));
                            if (items.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          child: Card(
                            color: context.colorScheme.secondaryContainer,
                            child: Center(
                              child: Text(items.elementAt(index)),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: items.length,
                  ),
                ),
              );
            },
          );
        });
  }
}

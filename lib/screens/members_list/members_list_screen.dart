import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';

class MembersListScreen extends ConsumerWidget {
  const MembersListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(memberControllerProvider);
    final currentTrip = ref.watch(tripDetailControllerProvider);
    var items = getListItemsForUser(userId: currentMember.id, currentTrip: currentTrip).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - ${currentMember.userProfileFirstname} ${currentMember.userProfileLastname}"),
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
                      const Center(child: Text('Uživatel nemá žádné veřejné položky.')),
                    ],
                  )
                : ListView(
                    children: items
                        .map(
                          (e) => ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(e.key),
                            children: e.value
                                .map(
                                  (val) => ListTile(
                                    title: Text(val.name),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (val.isShared)
                                          const Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(Icons.groups),
                                          ),
                                        Checkbox(value: val.isChecked, onChanged: null),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Item>> getListItemsForUser({required String userId, required Trip currentTrip}) {
    var member = currentTrip.members.firstWhere((element) => element.id == userId);
    //if (member == null) return {};
    var tmp = member.items.where((element) => !element.isPrivate);

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

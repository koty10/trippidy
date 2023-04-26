import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/model/item.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/member_controller.dart';

import '../../model/member.dart';
import '../add_item/add_item_screen.dart';

class OurListScreen extends ConsumerWidget {
  const OurListScreen({
    super.key,
    required this.currentTrip,
  });

  final Trip currentTrip;

  @override
  Widget build(BuildContext context, ref) {
    Member member = ref.watch(memberControllerProvider);
    var items = getOurListItems(member).entries;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - společný seznam"),
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
                        .map(
                          (e) => Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Text(e.key),
                              children: e.value
                                  .map(
                                    (val) => ListTile(
                                      title: Text(val.name),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (val.price != 0) Text("${val.price} Kč"),
                                          if (val.memberId != ref.read(memberControllerProvider).id)
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8, left: 16),
                                              child: CircleAvatar(
                                                radius: 12,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child:
                                                      Image.network(currentTrip.members.firstWhere((element) => element.id == val.memberId).userProfileImage!),
                                                ),
                                              ),
                                            ),
                                          Checkbox(
                                            //fillColor: val.memberId == ref.read(memberControllerProvider).id ? MaterialStateProperty.all(Colors.green) : null,
                                            value: val.isChecked,
                                            onChanged: val.memberId == ref.read(memberControllerProvider).id
                                                ? (value) {
                                                    val.isChecked = value ?? false;
                                                    ref.read(memberControllerProvider.notifier).updateItem(context, currentTrip.id, val);
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
                currentTrip: currentTrip,
                private: false,
                shared: true,
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, List<Item>> getOurListItems(Member member) {
    var tmp = ((currentTrip.members).where((m) => m.userProfileId != member.userProfileId).toList() + [member])
        .expand((element2) => element2.items)
        .where((element3) => element3.isShared)
        .toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }
    return dict;
  }
}

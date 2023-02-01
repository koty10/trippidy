import 'package:trippidy/model/trip.dart';
import 'package:trippidy/screens/members_list/members_list_screen.dart';
import 'package:trippidy/screens/my_list/my_list_screen.dart';
import 'package:trippidy/screens/our_list/our_list_screen.dart';
import 'package:trippidy/screens/trip/components/add_list_tile.dart';
import 'package:trippidy/screens/trip/components/member_list_tile.dart';
import 'package:flutter/material.dart';

import '../../model/item.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key, required this.currentTrip});

  final Trip currentTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(currentTrip.name),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/50x50/?portrait',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                InkWell(
                  child: const MemberListTile(
                    title: "Můj seznam",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyListScreen(
                          currentTrip: currentTrip,
                          myListItems: getMyListItems(tripId: currentTrip.id),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  child: const MemberListTile(
                    title: "Společný seznam",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OurListScreen(
                          currentTrip: currentTrip,
                          myListItems: getOurListItems(
                            tripId: currentTrip.id,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Seznamy ostatních členů',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: currentTrip.members.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == currentTrip.members.length) {
                  return AddListTile(
                      label: 'Přidat dalšího uživatele', onTap: () {});
                }
                var curMember = currentTrip.members[index];
                if (curMember == null) return const SizedBox.shrink();
                return InkWell(
                  child: MemberListTile(
                    title: curMember
                        .userId, //TODO get user from root collection by this id
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersListScreen(
                          currentTrip: currentTrip,
                          currentMember: curMember,
                          myListItems: getListItemsForUser(
                            userId: curMember.userId,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Item>> getListItemsForUser({required String userId}) {
    var member = currentTrip.members[userId];
    if (member == null) return {};
    var tmp = member.items.values.toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null
          ? dict[element.category]?.add(element)
          : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<Item>> getMyListItems({required String tripId}) {
    var member = currentTrip.members["id-membera"]; //TODO add
    if (member == null) return {};
    var tmp = member.items.values;

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null
          ? dict[element.category]?.add(element)
          : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<Item>> getOurListItems({required String tripId}) {
    //var member = currentTrip.members["2"];
    //if (member == null) return {};
    var tmp = (currentTrip.members.values.toList()) // + [member])
        .expand((element2) => element2.items.values)
        .where((element3) => element3.shared)
        .toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.category] != null
          ? dict[element.category]?.add(element)
          : dict.putIfAbsent(element.category, () => [element]);
    }
    return dict;
  }
}

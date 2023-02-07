import 'package:flutter/material.dart';

import '../../../model/trip.dart';
import '../../members_list/members_list_screen.dart';
import 'member_list_tile.dart';

class MembersListView extends StatelessWidget {
  final Trip currentTrip;

  const MembersListView({super.key, required this.currentTrip});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: currentTrip.members.length,
        itemBuilder: (BuildContext context, int index) {
          var curMember = currentTrip.members[index];
          if (curMember == null) return const SizedBox.shrink();
          //var curUser = curMember.fetchUser();
          return FutureBuilder(
            future: curMember.fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MemberListTile(
                  title: snapshot.data!.name,
                  currentTrip: currentTrip,
                  target: MembersListScreen(
                    currentTrip: currentTrip,
                    currentUser: snapshot.data!,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
      ),
    );
  }
}

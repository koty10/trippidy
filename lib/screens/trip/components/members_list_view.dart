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
        padding: const EdgeInsets.all(16),
        itemCount: currentTrip.members.length,
        itemBuilder: (BuildContext context, int index) {
          var curMember = currentTrip.members[index];
          return MemberListTile(
            member: curMember,
            title: "${curMember.userProfileFirstname} ${curMember.userProfileLastname}",
            currentTrip: currentTrip,
            target: const MembersListScreen(),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
      ),
    );
  }
}

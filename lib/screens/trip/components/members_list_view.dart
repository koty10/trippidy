import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../../../model/dto/member.dart';
import '../../../model/dto/trip.dart';
import '../../members_list/members_list_screen.dart';
import 'member_list_tile.dart';

class MembersListView extends ConsumerWidget {
  final Trip currentTrip;

  const MembersListView({super.key, required this.currentTrip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Member> members = currentTrip.members.where((element) => element.userProfileId != ref.read(authControllerProvider).userProfile!.id).toList();
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (BuildContext context, int index) {
          var curMember = members[index];
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/providers/member_controller.dart';

import '../../../model/trip.dart';

class MemberListTile extends ConsumerWidget {
  const MemberListTile({super.key, required this.title, required this.currentTrip, required this.target, required this.member, this.showGroupIcon = false});

  final String title;
  final Trip currentTrip;
  final Widget target;
  final Member member;
  final bool showGroupIcon;

  void initState() {}

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: !member.accepted
          ? null
          : () {
              ref.read(memberControllerProvider.notifier).setMember(member);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => target,
                ),
              );
            },
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: !member.accepted ? context.colorScheme.onInverseSurface : context.colorScheme.onSecondary,
        subtitle: !member.accepted ? const Text("Pozvánka odeslána") : null,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: showGroupIcon
              ? const Icon(Icons.groups)
              : CircleAvatar(
                  radius: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(currentTrip.members.firstWhere((element) => element.id == member.id).userProfileImage!),
                  ),
                ),
        ),
        title: Text(title, style: context.txtTheme.titleMedium),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        mouseCursor: SystemMouseCursors.click,
      ),
    );
  }
}

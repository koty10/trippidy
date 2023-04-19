import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/providers/member_controller.dart';

import '../../../model/trip.dart';

class MemberListTile extends ConsumerWidget {
  const MemberListTile({super.key, required this.title, required this.currentTrip, required this.target, this.member});

  final String title;
  final Trip currentTrip;
  final Widget target;
  final Member? member;

  void initState() {}

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: member != null && !member!.accepted
          ? null
          : () {
              member == null
                  ? ref.read(memberControllerProvider.notifier).setCurrentMember(currentTrip)
                  : ref.read(memberControllerProvider.notifier).setMember(member!);
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
        tileColor: member != null && !member!.accepted ? Colors.grey[600] : Colors.lightGreen[400],
        subtitle: member != null && !member!.accepted ? const Text("Pozvánka odeslána") : null,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        mouseCursor: SystemMouseCursors.click,
      ),
    );
  }
}

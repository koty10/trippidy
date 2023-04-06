import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/trip.dart';
import '../../../providers/member_provider.dart';

class MemberListTile extends ConsumerWidget {
  const MemberListTile({super.key, required this.title, required this.currentTrip, required this.target, this.setCurrentMember = false});

  final String title;
  final Trip currentTrip;
  final Widget target;
  final bool setCurrentMember;

  void initState() {}

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.lightGreen[400],
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
      onTap: () {
        if (setCurrentMember) ref.read(memberProvider.notifier).setMember(currentTrip.members[0]); // FIXME i have to get memberId somehow
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => target,
          ),
        );
      },
    );
  }
}

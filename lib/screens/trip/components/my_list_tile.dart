import 'package:anti_forgetter/model/trip_member_list_model.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  //const RecordTile({super.key, required this.record});

  const MyListTile({super.key, required this.memberList});

  final TripMemberListModel memberList;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      tileColor: Colors.amber,
      title: Text(
        memberList.user.name,
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
    );
  }
}

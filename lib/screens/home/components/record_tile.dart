import 'package:anti_forgetter/model/trip_model.dart';
import 'package:flutter/material.dart';

class RecordTile extends StatelessWidget {
  //const RecordTile({super.key, required this.record});

  RecordTile({super.key, required this.record})
      : recordMembers = record.members.length > 3
            ? record.members.map((e) => e[0]).take(2).toList() + ["..."]
            : record.members.map((e) => e[0]).take(3).toList();

  final TripModel record;
  final List<String> recordMembers; // = record.members.take(3).toList();

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      tileColor: Colors.amber,
      title: Text(
        record.name,
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: recordMembers
            .map(
              (member) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    member,
                    style: const TextStyle(
                      fontSize: 24,
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
                ),
              ),
            )
            .toList(),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    );
  }
}

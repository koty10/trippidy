import 'package:flutter/material.dart';

class MemberListTile extends StatelessWidget {
  const MemberListTile({super.key, required this.title});

  final String title;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
    );
  }
}

import 'package:flutter/material.dart';

class AddListTile extends StatelessWidget {
  const AddListTile({super.key, required this.label, required this.onTap});

  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(
          width: 2,
          color: Colors.lightGreen,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Colors.black54),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      leading: const Icon(
        Icons.add,
        color: Colors.lightGreen,
      ),
      onTap: () => onTap,
    );
  }
}

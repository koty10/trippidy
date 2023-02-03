import 'package:flutter/material.dart';

class DrawerDirectory extends StatelessWidget {
  const DrawerDirectory({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(title: const Text('Page One'), onTap: () {}),
          ListTile(title: const Text('Page Two'), onTap: () {})
        ],
      ),
    );
  }
}

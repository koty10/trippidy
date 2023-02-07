import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerDirectory extends StatelessWidget {
  const DrawerDirectory({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName ?? 'Chybí jméno'),
            accountEmail: Text(user.email ?? 'Chybí email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.photoURL == null ? const AssetImage("images/user.png") as ImageProvider : NetworkImage(user.photoURL!),
            ),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            currentAccountPictureSize: const Size.square(48),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Výlety'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Koš'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Odhlásit'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              GoogleSignIn().disconnect();
            },
          ),
        ],
      ),
    );
  }
}

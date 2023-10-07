import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/screens/edit_profile/edit_profile_screen.dart';

class HomeScreenDrawer extends ConsumerWidget {
  const HomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).userProfile!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${user.firstname} ${user.lastname}"),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.image == "" ? const AssetImage("images/user.png") as ImageProvider : NetworkImage(user.image),
            ),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            currentAccountPictureSize: const Size.square(48),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Výlety'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Upravit profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Koš'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Odhlásit'),
            onTap: () async {
              await ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}

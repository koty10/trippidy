import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          FirebaseAuth.instance.currentUser!.photoURL ??
              'https://source.unsplash.com/50x50/?portrait',
        ),
      ),
    );
  }
}

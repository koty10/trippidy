import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: (() {
          FirebaseAuth.instance.signOut();
          GoogleSignIn().disconnect();
        }),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.brown, // <-- Button color
        ),
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}

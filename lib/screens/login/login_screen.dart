import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../../contants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Přihlášení"),
      ),
      body: Center(
        child: SizedBox(
          width: 250,
          height: 80,
          child: OAuthProviderButton(
            provider: GoogleProvider(clientId: GOOGLE_CLIENT_ID),
            action: AuthAction.signIn,
          ),
        ),
      ),
    );
  }
}

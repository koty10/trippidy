import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Přihlaste se prosím",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: OAuthProviderButton(
                  provider: GoogleProvider(clientId: GOOGLE_CLIENT_ID),
                  action: AuthAction.signIn,
                  variant: OAuthButtonVariant.icon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

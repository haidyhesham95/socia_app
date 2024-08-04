import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../responsive/responsive_screen.dart';
import 'mobile_login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return ResponsiveScreen(); // If the user is signed in, show the home screen
        } else {
          return MobileLogin(); // If the user is not signed in, show the login screen
        }
      },
    );
  }
}

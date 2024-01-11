import 'package:attandance_management_system/auth/login_or_register.dart';
import 'package:attandance_management_system/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user if loggedin
          if (snapshot.hasData) {
            return const HomePage();
          }
          // user if not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}

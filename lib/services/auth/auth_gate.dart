// ignore_for_file: use_build_context_synchronously
import 'package:attandance_management_system/services/auth/admin_or_user.dart';
import 'package:attandance_management_system/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user if loggedin
          if (snapshot.hasData) {
            return const AdminOrUser();
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

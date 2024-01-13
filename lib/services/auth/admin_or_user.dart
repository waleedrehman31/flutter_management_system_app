import 'package:attandance_management_system/pages/admin/home_page.dart';
import 'package:attandance_management_system/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOrUser extends StatefulWidget {
  const AdminOrUser({super.key});

  @override
  State<AdminOrUser> createState() => _AdminOrUserState();
}

class _AdminOrUserState extends State<AdminOrUser> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isAdmin = false;
  Future<void> getUserRole() async {
    try {
      final user = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      if (user.get('role') == 'admin') {
        setState(() {
          isAdmin = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUserRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return const AdminHomePage();
    } else {
      return const HomePage();
    }
  }
}

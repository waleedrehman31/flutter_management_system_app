import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Attandance {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> markAttendance() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Get the current date
        String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

        // Add attendance record to Firestore
        await _firestore.collection('attendance').doc(user.uid).set({
          'date': currentDate,
          'marked': true,
        });
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}

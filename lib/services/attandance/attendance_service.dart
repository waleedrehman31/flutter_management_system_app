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
        String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
        // Check if attendance for the current date already exists
        DocumentSnapshot attendanceSnapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('attendance')
            .doc(date)
            .get();
        if (attendanceSnapshot.exists) {
          throw Exception('You have already marked attendance for today.');
        } else {
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('attendance')
              .doc(date)
              .set({
            'date': date,
            'time': "${DateTime.now().hour}:${DateTime.now().minute}",
            'marked': true,
          });
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}

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
            .collection('attandance')
            .doc(date)
            .get();
        if (attendanceSnapshot.exists) {
          throw Exception('You have already marked attendance for today.');
        } else {
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('attandance')
              .doc(date)
              .set({
            'date': date,
            'time': "${DateTime.now().hour}:${DateTime.now().minute}",
            'status': 'Present',
            'marked': true,
            'approved': true,
          });
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserAttandance() {
    User? user = _auth.currentUser;
    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('attandance')
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getAllAttandance() async {
    try {
      var allAttandance = <Map<String, dynamic>>[];
      QuerySnapshot users = await _firestore.collection('users').get();
      for (QueryDocumentSnapshot user in users.docs) {
        if (user.get('role') != "admin") {
          QuerySnapshot attandance = await _firestore
              .collection('users')
              .doc(user.id)
              .collection('attandance')
              .get();
          for (QueryDocumentSnapshot data in attandance.docs) {
            allAttandance.add({
              'attandanceUid': data.id,
              'userUid': user.id,
              'name': user.get('name'),
              'date': data.get('date'),
              'status': data.get('status'),
              'marked': data.get('marked'),
              'approved': data.get('approved'),
            });
          }
        }
      }
      return allAttandance;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> generateUserAttendanceReport(fromDate, toDate) async {
    try {
      QuerySnapshot userAttendanceSnapshot = await _firestore
          .collection('attendance')
          .where('date', isGreaterThanOrEqualTo: fromDate!.toIso8601String())
          .where('date', isLessThanOrEqualTo: toDate!.toIso8601String())
          .get();

      // Process the user attendance data as needed

      // Display or export the user attendance report based on your requirements
      print('User Attendance Report Generated:');
      print('From Date: ${fromDate!.toIso8601String()}');
      print('To Date: ${toDate!.toIso8601String()}');
      print('User Attendance Data: ${userAttendanceSnapshot.docs}');
    } catch (e) {
      print('Error generating user attendance report: $e');
    }
  }
}

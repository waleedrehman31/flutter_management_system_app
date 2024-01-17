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

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      var allUsers = <Map<String, dynamic>>[];
      QuerySnapshot users = await _firestore.collection('users').get();
      for (QueryDocumentSnapshot user in users.docs) {
        if (user.get('role') != "admin") {
          allUsers.add({
            'userUid': user.id,
            'name': user.get('name'),
          });
        }
      }
      return allUsers;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> generateUserAttendanceReport(
      fromDate, toDate, userUid) async {
    String fDate = DateFormat('dd-MM-yyyy').format(fromDate);
    String tDate = DateFormat('dd-MM-yyyy').format(toDate);
    String grade = "";
    var allAttandance = <Map<String, dynamic>>[];
    try {
      DocumentSnapshot<Map<String, dynamic>> userDetail =
          await _firestore.collection('users').doc(userUid).get();
      DocumentSnapshot<Map<String, dynamic>> getGrade =
          await _firestore.collection('config').doc('grades').get();
      QuerySnapshot userAttendanceSnapshot = await _firestore
          .collection('users')
          .doc(userUid)
          .collection('attandance')
          .where('date', isGreaterThanOrEqualTo: fDate)
          .where('date', isLessThanOrEqualTo: tDate)
          .get();
      if (userAttendanceSnapshot.size >= getGrade.get("a_grade")) {
        grade = "A Grade";
      } else if (userAttendanceSnapshot.size >= getGrade.get("b_grade") &&
          userAttendanceSnapshot.size <= getGrade.get("a_grade")) {
        grade = "B Grade";
      } else if (userAttendanceSnapshot.size >= getGrade.get("c_grade") &&
          userAttendanceSnapshot.size <= getGrade.get("b_grade")) {
        grade = "C Grade";
      } else {
        grade = "D Grade";
      }
      // Process the user attendance data as needed
      for (QueryDocumentSnapshot data in userAttendanceSnapshot.docs) {
        allAttandance.add({
          'attandanceUid': data.id,
          'name': userDetail.get('name'),
          'date': data.get('date'),
          'status': data.get('status'),
          'marked': data.get('marked'),
          'approved': data.get('approved'),
          'grade': grade
        });
      }
      return allAttandance;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}

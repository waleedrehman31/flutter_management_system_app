import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class LeaveService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendLeaveRequest() async {
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
          throw Exception(
              'You have already send request for today\'s leave. Or You Mark Attandance Today.');
        } else {
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('attandance')
              .doc(date)
              .set({
            'date': date,
            'time': "${DateTime.now().hour}:${DateTime.now().minute}",
            'status': 'Leave',
            'marked': true,
            'approved': false,
          });
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> getLeaveRequests() async {
    try {
      var allLeaveRequest = <Map<String, dynamic>>[];
      QuerySnapshot users = await _firestore.collection('users').get();
      for (QueryDocumentSnapshot user in users.docs) {
        if (user.get('role') != "admin") {
          QuerySnapshot attandance = await _firestore
              .collection('users')
              .doc(user.id)
              .collection('attandance')
              .get();
          for (QueryDocumentSnapshot data in attandance.docs) {
            if (data.get('approved') == false) {
              allLeaveRequest.add({
                'id': data.id,
                'date': data.get('date'),
                'status': data.get('status'),
                'marked': data.get('marked'),
                'approved': data.get('approved'),
              });
            }
          }
        }
      }
      return allLeaveRequest;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class GradeSystemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getGradingSystem() async {
    try {
      var allGrades = <Map<String, dynamic>>[];
      // get grading system  in Firestore
      QuerySnapshot grades = await _firestore.collection('config').get();
      for (QueryDocumentSnapshot data in grades.docs) {
        allGrades.add({
          'a_grade': data.get('a_grade'),
          'b_grade': data.get('b_grade'),
          'c_grade': data.get('c_grade'),
          'd_grade': data.get('d_grade'),
        });
      }
      return allGrades;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> saveGradingSystem(String aGrade, bGrade, cGrade, dGrade) async {
    try {
      // Save grading system  in Firestore
      await _firestore.collection('config').doc('grades').set({
        'a_grade': int.parse(aGrade),
        'b_grade': int.parse(bGrade),
        'c_grade': int.parse(cGrade),
        'd_grade': int.parse(dGrade),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}

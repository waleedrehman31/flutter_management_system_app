import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<UserInfo>> getUserInformation() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user.providerData;
      } else {
        return [];
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> updateUserInformation(String name, email) async {
    try {
      // Get the current date
      User? user = _auth.currentUser;
      if (user != null) {
        // Add attendance record to Firestore
        await user.updateDisplayName(name);
        await user.updateEmail(email);
        await user
            .updatePhotoURL("https://example.com/jane-q-user/profile.jpg");
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}

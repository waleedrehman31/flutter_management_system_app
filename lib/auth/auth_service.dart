import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in functino
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

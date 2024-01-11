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

  // Sign Up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // errors
}

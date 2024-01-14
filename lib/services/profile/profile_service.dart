import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  Future<void> updateUserInformation(String name, email, photoUrl) async {
    User? user = _auth.currentUser;
    try {
      // Get the current date
      if (user != null) {
        // Add attendance record to Firestore
        await user.updateDisplayName(name);
        await user.updateEmail(email);
        await user.updatePhotoURL(photoUrl);
        await _firebaseFirestore.collection('users').doc(user.uid).update({
          'name': name,
          'email': email,
          'photoUrl': photoUrl,
        });
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getImageUrl(File image, String imageName) async {
    var firebaseStorage = FirebaseStorage.instance;
    try {
      var snapshot =
          firebaseStorage.ref().child(imageName).putFile(image).snapshot;
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}

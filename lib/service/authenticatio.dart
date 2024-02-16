import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUsername(String newUsername) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(newUsername);
      await _firestore.collection('user').doc(user.uid).update({'username': newUsername});
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePhotoURL(imageUrl);
      await _firestore.collection('user').doc(user.uid).update({'imageUrl': imageUrl});
    }
  }
  
}
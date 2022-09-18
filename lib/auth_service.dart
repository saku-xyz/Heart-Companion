import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/user_data.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> createUserWithEmailAndPassword(String email, String password, String userName) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await currentUser.user.updateProfile(
      displayName: userName,
    ).then((value) async {
      await currentUser.user.reload();
    });

    final refreshUser = await getCurrentUser();

    return refreshUser;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final currentUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return currentUser.user;
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User> removeUser() async {
    User user = _firebaseAuth.currentUser;
    user.delete();
    return null;
  }

  signOut(){
    appUser = null;
    return _firebaseAuth.signOut();
  }
}

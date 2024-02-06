import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth auth;

  AuthController(this.auth);

  Future<FirebaseAuth> SignUp(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
    return auth;
  }

  Future<FirebaseAuth> SignIn(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
    return auth;
  }

  Future<void> SignOut() async {
    try {
      await auth.signOut();
      log("Çikiş Yapildi");
    } catch (e) {
      log(e.toString());
    }
  }
}

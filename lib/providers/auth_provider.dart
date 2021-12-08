import 'package:chat/data/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/data/user.dart' as app_user;

class AuthProvider extends ChangeNotifier {
  AuthProvider(){
    fetchFirestoreUser();
  }
  app_user.User? user;
  updateUser(app_user.User user) {
    this.user = user;
    notifyListeners();
  }

  void fetchFirestoreUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var FirestoreUser =
          await getUserById(FirebaseAuth.instance.currentUser!.uid);
      user = FirestoreUser;
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}

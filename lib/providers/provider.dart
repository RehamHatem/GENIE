import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genie/models/user%20model.dart';
import '../network/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  User? firebaseUser;
  UserModel? userModel;
  var firebaseFunctions=new FirebaseFunctions();
  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {

    userModel = await firebaseFunctions.readUser();
    notifyListeners();
  }
}


import 'package:flutter/material.dart';
import 'package:genie/providers/provider.dart';

import '../../network/firebase_functions.dart';
import 'login_navigator.dart';

class LoginViewModel extends ChangeNotifier{
  var emailController= TextEditingController();
  var passwordController=TextEditingController();
  var firebaseFunctions = FirebaseFunctions();
  bool isLoading = false;
  late LoginNavigator navigator;
  void login(MyProvider provider){
    firebaseFunctions.login(
        emailController.text, passwordController.text,
            () async {
          provider.initUser();
            isLoading = false;
            navigator.navigate();

        }, (message) {
        isLoading = false;
        return navigator.showMyDialog(message);
    });

  }


}
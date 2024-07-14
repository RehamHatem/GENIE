
import 'package:flutter/material.dart';
import 'package:genie/Auth/signin/signup_navigator.dart';

import '../../network/firebase_functions.dart';

class SigninViewModel extends ChangeNotifier{
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var userNameController=TextEditingController();
  var phoneController=TextEditingController();
  var firebaseFunctions = FirebaseFunctions();
  bool isLoading = false;

  late SigninNavigator navigator;
  void signin(){

    firebaseFunctions.creatAccount(
        email: emailController.text,
        password: passwordController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        onSuccess: () {
            isLoading = false;
            navigator.navigate();
        },
        onError: (errorMessage) {
            isLoading = false;
            return navigator.showMyDialog(errorMessage.toString());
        });
  }
  notifyListeners();

}
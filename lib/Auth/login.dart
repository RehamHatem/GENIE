import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase_functions.dart';
import '../provider.dart';
import '../screens/layout.dart';
import '../user model.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var firebaseFunctions = new FirebaseFunctions();

  bool secure = false;
  bool emailHasFocus = false;
  bool passwordHasFocus = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    emailHasFocus = hasFocus;
                  });
                },
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Color(0xff233774),
                  decoration: InputDecoration(
                    label: Text(
                      "email",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: emailHasFocus ? Color(0xff233774) : Colors.grey,
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: emailHasFocus ? Color(0xffc5607e) : Colors.grey,
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff161616))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff161616))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff233774))),
                    errorStyle: TextStyle(color: Color(0xffc5607e)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    passwordHasFocus = hasFocus;
                  });
                },
                child: TextFormField(
                  controller: passwordController,
                  obscureText: secure == true ? true : false,
                  cursorColor: Color(0xff233774),
                  decoration: InputDecoration(
                      label: Text(
                        "password",
                        style: TextStyle(fontSize: 20),
                      ),
                      labelStyle: TextStyle(
                        color:
                            passwordHasFocus ? Color(0xff233774) : Colors.grey,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            secure = !secure;
                            setState(() {});
                          },
                          child: secure == false
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: passwordHasFocus
                                      ? Color(0xffc5607e)
                                      : Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: passwordHasFocus
                                      ? Color(0xffc5607e)
                                      : Colors.grey,
                                )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xffc5607e))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff161616))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff233774))),
                      errorStyle: TextStyle(color: Color(0xffc5607e))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff233774), Color(0xffc5607e)]),
                          borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            firebaseFunctions.login(
                                emailController.text, passwordController.text,
                                () async {
                              provider.initUser();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Home.routeName, (route) => false);
                            }, (message) {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(message),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    actions: [
                                      Center(
                                          child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"),
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xffc5607e))),
                                      ))
                                    ],
                                  );
                                },
                              );
                            });
                          }
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

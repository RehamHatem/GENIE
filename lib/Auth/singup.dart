import 'package:flutter/material.dart';

import '../firebase_functions.dart';
import '../screens/layout.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var firebaseFunctions = new FirebaseFunctions();

  bool secure = false;
  bool nameHasFocus = false;
  bool phoneHasFocus = false;
  bool emailHasFocus = false;
  bool passwordHasFocus = false;

  @override
  Widget build(BuildContext context) {
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
                    nameHasFocus = hasFocus;
                  });
                },
                child: TextFormField(
                  controller: userNameController,
                  cursorColor: Color(0xff233774),
                  decoration: InputDecoration(
                      label: Text(
                        "name",
                        style: TextStyle(fontSize: 20),
                      ),
                      labelStyle: TextStyle(
                        color: nameHasFocus ? Color(0xff233774) : Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.person,
                        color: nameHasFocus ? Color(0xffc5607e) : Colors.grey,
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
                      errorStyle: TextStyle(color: Color(0xffc5607e))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter You Name';
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
                    phoneHasFocus = hasFocus;
                  });
                },
                child: TextFormField(
                  controller: phoneController,
                  cursorColor: Color(0xff233774),
                  decoration: InputDecoration(
                      label: Text(
                        "phone",
                        style: TextStyle(fontSize: 20),
                      ),
                      labelStyle: TextStyle(
                        color: phoneHasFocus ? Color(0xff233774) : Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.phone,
                        color: phoneHasFocus ? Color(0xffc5607e) : Colors.grey,
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
                      errorStyle: TextStyle(color: Color(0xffc5607e))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone';
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
                    emailHasFocus = hasFocus;
                  });
                },
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Color(0xff233774),
                  decoration: InputDecoration(
                      label: Text(
                        "email",
                        style: TextStyle(fontSize: 20),
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
                      errorStyle: TextStyle(color: Color(0xffc5607e))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Please write email valid ex: xx@xx.com";
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
                          borderSide: BorderSide(color: Color(0xff161616))),
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
                    if (value.length < 6) {
                      return "password should be at least 6 char";
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
                            firebaseFunctions.creatAccount(
                                email: emailController.text,
                                password: passwordController.text,
                                userName: userNameController.text,
                                phone: phoneController.text,
                                onSuccess: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Home.routeName, (route) => false);
                                },
                                onError: (errorMessage) {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(errorMessage),
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
                                                            BorderRadius
                                                                .circular(15))),
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
                          "SignIn",
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

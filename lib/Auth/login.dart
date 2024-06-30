import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genie/Auth/singup.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../network/firebase_functions.dart';
import '../providers/provider.dart';
import '../screens/layout.dart';
import '../models/user model.dart';
import 'about_genie.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
  static const String routeName = "log";
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var firebaseFunctions = FirebaseFunctions();

  bool secure = false;
  bool emailHasFocus = false;
  bool passwordHasFocus = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 150.h,
            backgroundColor: Color(0xffececec),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.r),
                    bottomLeft: Radius.circular(50.r))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GradientText(
                  "Welcome to GINIE",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40.sp,
                  ),
                  colors: [Color(0xff233774), Color(0xffc5607e)],
                ),
                SizedBox(
                  height: 3,
                ),
                Text("Enter your credentials to login.",
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87)),
              ],
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding:  EdgeInsets.only(right: 5.w, left: 5.w),
            child: Form(
              key: _formKey,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
                                fontSize: 20.sp,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: emailHasFocus ? Color(0xff233774) : Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.email,
                              color: emailHasFocus ? Color(0xffc5607e) : Colors.grey,
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffc5607e))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(color: Color(0xff161616))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(color: Color(0xff161616))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
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
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
                                style: TextStyle(fontSize: 20.sp),
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
                              focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffc5607e))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xff161616))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xff161616))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
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
                       EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.0.h),
                      child: Center(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0xff233774), Color(0xffc5607e)]),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    firebaseFunctions.login(
                                        emailController.text, passwordController.text,
                                            () async {
                                          provider.initUser();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, Home.routeName, (route) => false);
                                        }, (message) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(message),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(25.r)),
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
                                                                    15.r))),
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
                                      fontSize: 20.sp, fontWeight: FontWeight.w400),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                                  elevation: MaterialStatePropertyAll(0),
                                ),
                              ))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, SignIn.routeName);
                            },
                            child: Text("Create account",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xffc5607e)),))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("About ",),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AboutGenie.routeName);
                          },
                          child: GradientText(
                            "GENIE",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                            colors: [Color(0xff233774), Color(0xffc5607e)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(color: Color(0xffc5607e)),
            ),
          ),
      ],
    );
  }
}

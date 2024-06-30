import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../network/firebase_functions.dart';
import '../screens/layout.dart';
import 'about_genie.dart';
import 'login.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
  static const String routeName="sign";

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 150.h,
            backgroundColor: Color(0xffececec),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.r),bottomLeft: Radius.circular(50.r))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GradientText(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40.sp,

                  ),
                  colors: [Color(0xff233774), Color(0xffc5607e)],
                ),
                SizedBox(height: 3.h,),
                Text("Create your account.",style: TextStyle(fontSize: 15.sp,color:Color(0xff161616) )),
              ],
            ),
            centerTitle: true,

          ),

          body: Padding(
            padding:  EdgeInsets.only(right: 5.w,left: 5.w),
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
                            nameHasFocus = hasFocus;
                          });
                        },
                        child: TextFormField(
                          controller: userNameController,
                          cursorColor: Color(0xff233774),
                          decoration: InputDecoration(
                              label: Text(
                                "name",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              labelStyle: TextStyle(
                                color: nameHasFocus ? Color(0xff233774) : Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.person,
                                color: nameHasFocus ? Color(0xffc5607e) : Colors.grey,
                              ),
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
                              return 'Please enter You Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              labelStyle: TextStyle(
                                color: phoneHasFocus ? Color(0xff233774) : Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: phoneHasFocus ? Color(0xffc5607e) : Colors.grey,
                              ),
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
                              return 'Please enter your Phone';
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
                            emailHasFocus = hasFocus;
                          });
                        },
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: Color(0xff233774),
                          decoration: InputDecoration(
                              label: Text(
                                "email",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              labelStyle: TextStyle(
                                color: emailHasFocus ? Color(0xff233774) : Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.email,
                                color: emailHasFocus ? Color(0xffc5607e) : Colors.grey,
                              ),
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
                      padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
                                    firebaseFunctions.creatAccount(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        userName: userNameController.text,
                                        phone: phoneController.text,
                                        onSuccess: () {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushNamedAndRemoveUntil(context,
                                              LogIn.routeName, (route) => false);
                                        },
                                        onError: (errorMessage) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(errorMessage),
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
                                                                    BorderRadius
                                                                        .circular(15.r))),
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
                        Text("Already have an account? "),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, LogIn.routeName);
                            },
                            child: Text("login to your account",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xffc5607e)),))
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

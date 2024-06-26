import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genie/Auth/singup.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'login.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName="auth";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xff161616),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xffc5607e),
            tabs: [
              Tab(text: "login"),
              Tab(text: "signin"),

            ],
          ),

          title:GradientText(
            "GENIE",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 35,
            ),
            colors: [Color(0xff233774), Color(0xffc5607e)],
          ),
        ),
        body: TabBarView(
          children: [
            LogIn(),
            SignIn()
          ],
        ),

      ),
    );
  }
}

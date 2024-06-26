import 'dart:async';

import 'package:flutter/material.dart';

import 'Auth/Authentication.dart';
import 'Auth/login.dart';
import 'screens/layout.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, LogIn.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/images/Picture1.jpg")),
          SizedBox(height: 20),

          Column(
            children: [
              Text("Search In Your Gallary",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20,

    )),
              Text("Fast And Accurate",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,

              ))
            ],
          )
        ],
      ),


    );
  }
}

import 'package:flutter/material.dart';
import 'package:genie/splash.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context) => SplashScreen(),
        Home.routeName:(context) => Home(),


      },

    );
  }
}



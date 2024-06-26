import 'package:flutter/material.dart';
import 'package:genie/provider.dart';
import 'package:genie/splash.dart';
import 'package:provider/provider.dart';
import 'Auth/Authentication.dart';
import 'screens/layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
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
        AuthScreen.routeName:(context) => AuthScreen(),


      },

    );
  }
}



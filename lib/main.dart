import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genie/providers/provider.dart';
import 'package:genie/splash.dart';
import 'package:provider/provider.dart';
import 'Auth/Authentication.dart';
import 'Auth/about_genie.dart';
import 'Auth/login/login.dart';
import 'Auth/signin/singup.dart';
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

    
    return ScreenUtilInit(

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName:(context) => SplashScreen(),
          Home.routeName:(context) => Home(),
          LogIn.routeName:(context) => LogIn(),
          SignIn.routeName:(context) => SignIn(),
          AboutGenie.routeName:(context) => AboutGenie(),


        },

      ),
    );
  }
}



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:genie/screens/search_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';
//
// import '../firebase_functions.dart';
// import 'home_screen.dart';
//
// class Home extends StatefulWidget {
//   static const String routeName = "home";
//
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   int index = 0;
//
//   final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _uploadImage() async {
//     try {
//       String? downloadUrl =
//       await _firebaseFunctions.uploadImageToFirebase(_image);
//       if (downloadUrl != null) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Image uploaded successfully!'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to upload image: URL is null'),
//         ));
//       }
//     } catch (e) {
//       print('Failed to upload image: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to upload image: $e'),
//       ));
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//     await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Center(child: CircularProgressIndicator());
//         },
//       );
//       await _uploadImage();
//       Navigator.pop(context);
//     }
//   }
//
//   Future<void> _captureImageWithCamera() async {
//     final XFile? pickedFile =
//     await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Center(child: CircularProgressIndicator());
//         },
//       );
//       await _uploadImage();
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff161616),
//         centerTitle: true,
//         // toolbarHeight: 60,
//         title:
//         // Image(image: AssetImage("assets/images/Picture1.jpg"),fit: BoxFit.fill,height: 60,)
//
//         GradientText(
//           "GENIE",
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 35,
//           ),
//           colors: [Color(0xff233774), Color(0xffc5607e)],
//         ),
//       ),
//       body: screens[index],
//       floatingActionButton: index == 0
//           ? Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: _captureImageWithCamera,
//             backgroundColor: Color(0xff161616),
//             child: Icon(Icons.camera_alt, size: 30),
//             hoverColor: Colors.grey,
//           ),
//           SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: _pickImage,
//             backgroundColor: Color(0xff161616),
//             child: Icon(Icons.photo, size: 30),
//             hoverColor: Colors.grey,
//           ),
//         ],
//       )
//           : Column(),
//       bottomNavigationBar: BottomAppBar(
//         padding: EdgeInsets.zero,
//         color: Color(0xff161616),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           unselectedItemColor: Color(0xff686e74),
//           selectedItemColor: Colors.white,
//           iconSize: 30,
//           selectedLabelStyle: TextStyle(fontSize: 15),
//           type: BottomNavigationBarType.fixed,
//           currentIndex: index,
//           onTap: (value) {
//             index = value;
//             setState(() {});
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: "Search",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> screens = [
//     HomeScreen(),
//     SearchScreen(),
//   ];
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:genie/screens/search_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../Auth/Authentication.dart';
import '../firebase_functions.dart';
import '../provider.dart';
import '../user model.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  late Future<String?> userName;

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    try {
      String? downloadUrl =
          await _firebaseFunctions.uploadImageToFirebase(_image);
      if (downloadUrl != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image uploaded successfully!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload image: URL is null'),
        ));
      }
    } catch (e) {
      print('Failed to upload image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload image: $e'),
      ));
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      await _uploadImage();
      Navigator.pop(context);
    }
  }

  Future<void> _captureImageWithCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      await _uploadImage();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SafeArea(
                  child: SizedBox(
                height: 10,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hello ",
                      style: TextStyle(color: Color(0xff233774), fontSize: 30)),
                  Text("${provider.userModel?.userName}",
                      style: TextStyle(color: Color(0xffc5607e), fontSize: 30)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SignOut",
                      style: TextStyle(fontSize: 25, color: Color(0xffc5607e))),
                  IconButton(
                      onPressed: () {
                        _firebaseFunctions.logOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AuthScreen.routeName, (route) => false);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Color(0xff233774),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff161616),
        centerTitle: true,
        title: GradientText(
          "GENIE",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 35,
          ),
          colors: [Color(0xff233774), Color(0xffc5607e)],
        ),
      ),
      body: screens[index],
      floatingActionButton: index == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _captureImageWithCamera,
                  backgroundColor: Color(0xff161616),
                  child: Icon(Icons.camera_alt, size: 30),
                  hoverColor: Colors.grey,
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _pickImage,
                  backgroundColor: Color(0xff161616),
                  child: Icon(Icons.photo, size: 30),
                  hoverColor: Colors.grey,
                ),
              ],
            )
          : Column(),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Color(0xff161616),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          unselectedItemColor: Color(0xff686e74),
          selectedItemColor: Colors.white,
          iconSize: 30,
          selectedLabelStyle: TextStyle(fontSize: 15),
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
  ];
}

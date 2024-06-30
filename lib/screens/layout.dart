
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:genie/screens/search_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../Auth/login.dart';
import '../network/firebase_functions.dart';
import '../providers/provider.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    try {
      String? downloadUrl =
          await _firebaseFunctions.uploadImageToFirebase(_image,);
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
          return Center(child: CircularProgressIndicator(color: Color(0xffc5607e)),);
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
          return Center(child: CircularProgressIndicator(color: Color(0xffc5607e),));
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
      extendBody: true,
       extendBodyBehindAppBar: true,
      endDrawer:  Drawer(
        backgroundColor:Color(0xffeaeaea),
        width: 230,

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
                  Text("${provider.userModel?.userName } ",
                      style: TextStyle(color: Color(0xffc5607e), fontSize: 30)),
                  Icon(Icons.waving_hand)
                ],
              ),
              Divider(color: Colors.grey),
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
                            context, LogIn.routeName, (route) => false);
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
      key: _scaffoldKey,

      appBar: index==0? AppBar(
        elevation: 0,
        // backgroundColor: Color(0xff161616),
         backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.transparent,),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        centerTitle: true,
        title: GradientText(
          "All",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            decorationThickness: 3,
            decorationColor: Colors.black,

          ),
          colors: const [Color(0xff233774), Color(0xffc5607e)],
        ),
      ):null,
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
        // shape: AutomaticNotchedShape(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),

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
              if (value == 2) {
                _scaffoldKey.currentState?.openEndDrawer();
              } else {
                setState(() {
                  index = value;
                });
              }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert_sharp),
              label: "More",
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

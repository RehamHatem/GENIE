import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int index=0;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff161616),
centerTitle: true,
        // toolbarHeight: 60,
        title:
          // Image(image: AssetImage("assets/images/Picture1.jpg"),fit: BoxFit.fill,height: 60,)

        GradientText(
          "GENIE",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 35,
          ),
          colors: [
            Color(0xff233774),
            Color(0xffc5607e)
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Color(0xff161616) ,
        child: IconButton(icon: Icon(Icons.add,size: 30),onPressed: _pickImage,),
        hoverColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        color:Color(0xff161616) ,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          unselectedItemColor: Color(0xff686e74),
          selectedItemColor: Colors.white,
          iconSize: 30,
          selectedLabelStyle: TextStyle(
            fontSize: 15
          ),
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            index=value;
            setState(() {

            });
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
}

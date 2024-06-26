import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutGenie extends StatelessWidget {
  static const String routeName="about";
  const AboutGenie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffececec),
        iconTheme: IconThemeData(color:Colors.black87 ),
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''   Welcome to GINIE, your ultimate photo management companion! GINIE is a revolutionary search gallery application designed to enhance your photo organization and retrieval experience. Acting as your personal gallery, GINIE leverages advanced image captioning technology to make managing your photos effortless and intuitive.

When you import or capture photos, GINIE's sophisticated image captioning model automatically generates descriptive captions for each image. These captions provide a concise summary of the photo content, making it easier than ever to find specific pictures in your vast collection.

Gone are the days of endlessly scrolling through your gallery to find that one special photo. With GINIE, you can simply type a query that describes the image you're looking for, and the application will swiftly present you with all the photos that match your description. Whether it's a memorable vacation, a family gathering, or a scenic sunset, GINIE ensures your cherished moments are just a search away.

GINIE's intuitive interface and powerful search capabilities transform the way you interact with your photo library. The application not only saves you time but also enhances your ability to relive precious memories by making photo discovery seamless and enjoyable.

Experience the future of photo management with GINIE. Enjoy the convenience of having a smart gallery that understands your needs and delivers the exact photos you seek. Download GINIE today and take the first step towards an organized, accessible, and intelligent photo collection. Let GINIE bring your memories to life with just a few keystrokes, and rediscover the joy of capturing and sharing your favorite moments.
          ''',style: TextStyle(fontSize: 20,)),
        ),
      ),
    );
  }
}

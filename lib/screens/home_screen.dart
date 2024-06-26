// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../firebase_functions.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> _imageUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchImages();
//   }
//
//   Future<void> fetchImages() async {
//     try {
//       List<String> urls = await FirebaseFunctions().getImagesFromFirestore();
//       setState(() {
//         _imageUrls = urls;
//       });
//     } catch (e) {
//       print('Error fetching images: $e');
//       // Handle error gracefully (e.g., show error message to the user)
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('images').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No images available.'));
//         }
//
//         return Expanded(
//             child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//         ),
//         itemCount: _imageUrls.length,
//         itemBuilder: (BuildContext context, int index) {
//         return Image.network(
//         _imageUrls[index],
//         fit: BoxFit.cover,
//         );
//         },
//             ),
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      List<String> urls = await FirebaseFunctions().getImagesFromFirestore();
      setState(() {
        _imageUrls = urls;
      });
    } catch (e) {
      print('Error fetching images: $e');
      // Handle error gracefully (e.g., show error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('images').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No images available.'));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: _imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              _imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        );
      },
    );
  }
}


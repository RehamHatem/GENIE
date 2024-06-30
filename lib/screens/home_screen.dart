import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:genie/screens/view%20image.dart';

import '../network/firebase_functions.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('images').where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Color(0xffc5607e),));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No images available.'));
        }

        var imageDocs = snapshot.data!.docs;


        return Column(
          children: [
            // Text("All",style: TextStyle(decoration: TextDecoration.underline,color: Color( 0xff161616),fontSize: 20,height: 1.5,decorationThickness: 3,decorationColor: Color(0xffc5607e)),),
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                ),
                itemCount: imageDocs.length,
                itemBuilder: (context, int index) {
                  var imageUrl = imageDocs[index]['url'];
                  var caption = imageDocs[index]['caption'];
                  var imageDoc = imageDocs[index];
                  return Stack(
                     alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImageView(
                                      images: imageDocs,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                   imageUrl,

                                  fit: BoxFit.cover,

                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xffc5607e),
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(child: Icon(Icons.error));
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                caption,
                                style: TextStyle(
                                    color: Color(0xff161616),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            await _firebaseFunctions.deleteImage(imageDoc.id, imageUrl);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Image deleted successfully'),
                              backgroundColor: Colors.green,
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to delete image: $e'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                          icon: Icon(Icons.remove_circle,color: Color(0xffc5607e),size: 20),


                      ),
                      
                    ],
                  );

                },
              ),
            ),

          ],
        );
      },
    );
  }
}

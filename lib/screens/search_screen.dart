import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool searchHasFocus = false;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 60),
      child: Column(
        children: [

          Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                searchHasFocus = hasFocus;
              });
            },
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },

              cursorColor: Color(0xff233774),
              decoration: InputDecoration(
                label: Text(
                  "search in your gallery ...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                labelStyle: TextStyle(
                  color: searchHasFocus ? Color(0xff233774) : Colors.grey,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: searchHasFocus ? Color(0xffc5607e) : Colors.grey,
                ),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffc5607e))),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff161616))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff161616))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff233774))),
                errorStyle: TextStyle(color: Color(0xffc5607e)),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(colors: [Color(0xff233774), Color(0xffc5607e)],"Tips for good search",style: TextStyle(fontSize: 22,
                  ),),
              IconButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      title: Center(child: Text("Search Tips",)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("1. Use keywords related to your images."),
                          Text("2. Try using singular and plural forms."),
                          Text("3. Check for any spelling errors."),
                        ],
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: ElevatedButton(
                            onPressed: () {
                    Navigator.pop(context);
                    },
                    child: Text("Okay"),
                    style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                    15))),
                    backgroundColor:
                    MaterialStatePropertyAll(
                    Color(0xffc5607e))),
                    )),
                        ),

                      ],
                    );
                  },
                );
              }, icon: Icon(Icons.tips_and_updates,color: Colors.yellow,size: 30,))
            ],
          )
          // Expanded(
          //   child: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection('images')
          //         .where('userId', isEqualTo: userId)
          //         .snapshots(),
          //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(child: Text('Error: ${snapshot.error}'));
          //       }
          //
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //             child: CircularProgressIndicator(
          //               color: Color(0xffc5607e),
          //             ));
          //       }
          //
          //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //         return Center(child: Text('No images available.'));
          //       }
          //
          //       var imageDocs = snapshot.data!.docs.where((doc) {
          //         var data = doc.data() as Map<String, dynamic>;
          //         var url = data['url'] as String;
          //         return url.toLowerCase().contains(_searchQuery);
          //       }).toList();
          //
          //       if (imageDocs.isEmpty) {
          //         return Center(child: Text('No images match your search.'));
          //       }
          //
          //       return MasonryGridView.builder(
          //         gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //         ),
          //         itemCount: imageDocs.length,
          //         itemBuilder: (context, int index) {
          //           var imageUrl = imageDocs[index]['url'];
          //           return Padding(
          //             padding: const EdgeInsets.all(2.0),
          //             child: ClipRRect(
          //               borderRadius: BorderRadius.circular(10),
          //               child: Image.network(
          //                 imageUrl,
          //                 fit: BoxFit.cover,
          //                 loadingBuilder: (context, child, loadingProgress) {
          //                   if (loadingProgress == null) return child;
          //                   return Center(
          //                     child: CircularProgressIndicator(
          //                       color: Color(0xffc5607e),
          //                       value: loadingProgress.expectedTotalBytes != null
          //                           ? loadingProgress.cumulativeBytesLoaded /
          //                           (loadingProgress.expectedTotalBytes ?? 1)
          //                           : null,
          //                     ),
          //                   );
          //                 },
          //                 errorBuilder: (context, error, stackTrace) {
          //                   return Center(child: Icon(Icons.error));
          //                 },
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

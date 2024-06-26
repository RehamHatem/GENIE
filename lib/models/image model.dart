import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String url;
  final String userId;

  ImageModel({required this.url, required this.userId});

  factory ImageModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ImageModel(
      url: data['url'],
      userId: data['userId'],
    );
  }
}

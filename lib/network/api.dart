import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APImanager {
// https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-large
  Future<String> generateCaption(File image) async {
    final API_URL = "https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-large";
    final headers = {"Authorization": "Bearer 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"};

    try {
      final response = await http.post(
        Uri.parse(API_URL),
        headers: headers,
        body: await image.readAsBytes(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);
        return result[0]["generated_text"];
      } else {
        print('Failed to generate caption: ${response.reasonPhrase}');
        return 'No caption available';
      }
    } catch (e) {
      print('Error generating caption: $e');
      return 'No caption available';
    }
  }
  Future<List<double>> generateEmbedding(String text) async {
    final response = await http.post(
      Uri.parse('https://cf48-41-44-9-113.ngrok-free.app/embedding'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );
    if (response.statusCode == 200) {
      return List<double>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate embedding');
    }
  }

  Future<List<int>> performSemanticSearch(List<double> queryEmbedding, List<List<double>> captionsEmbeddings) async {
    final response = await http.post(
      Uri.parse('https://cf48-41-44-9-113.ngrok-free.app/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query_embedding': queryEmbedding,
        'captions_embeddings': captionsEmbeddings,

      }),
    );

    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch search results');
    }
  }

  // Future<List<DocumentSnapshot>> performSemanticSearch(String query) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //   final imagesSnapshot = await _firestore
  //       .collection('images')
  //       .where('userId', isEqualTo: userId)
  //       .get();
  //
  //   List<String> captions = imagesSnapshot.docs.map((doc) {
  //     final data = doc.data() as Map<String, dynamic>;
  //     return data['caption'] as String;
  //   }).toList();
  //
  //   final response = await http.post(
  //     Uri.parse('http://localhost:5000/semantic_search'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'query': query, 'captions': captions}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> results = jsonDecode(response.body);
  //     final List<String> resultCaptions = results.cast<String>();
  //     final List<DocumentSnapshot> sortedDocs = [];
  //
  //     for (var result in resultCaptions) {
  //       final index = captions.indexOf(result);
  //       if (index != -1) {
  //         sortedDocs.add(imagesSnapshot.docs[index]);
  //       }
  //     }
  //
  //     return sortedDocs;
  //   } else {
  //     throw Exception('Failed to fetch search results');
  //   }
  // }
}
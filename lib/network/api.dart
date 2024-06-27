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
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyDeJxMqy2267fEXUxEOqx38Tagr5MZgMhQ"; // ضع مفتاح API هنا
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey";

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {"parts": [{"text": message}]}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "خطأ في الاستجابة من السيرفر: ${response.statusCode}";
      }
    } catch (e) {
      return "حدث خطأ أثناء الاتصال: $e";
    }
  }
}

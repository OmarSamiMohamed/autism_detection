import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiUrl = "https://api.together.xyz/v1/chat/completions"; // رابط Together AI
  static const String apiKey = "689757dc5b8fbe3679d0ca06120e9e8eefab2dcabd0bc24b6885b46d5afa5cb3"; // ضع مفتاح Together AI هنا

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey", // المفتاح هنا
        },
        body: jsonEncode({
         "model": "mistralai/Mistral-7B-Instruct-v0.2", // يمكنك تجربة gpt-3.5-turbo أو gemma-7b
          "messages": [
            {"role": "system", "content": "أنت مساعد ذكي يجيب على الأسئلة."},
            {"role": "user", "content": message}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"]; // استخراج رد النموذج
      } else {
        return "❌ خطأ: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "❌ خطأ في الاتصال: $e";
    }
  }
}

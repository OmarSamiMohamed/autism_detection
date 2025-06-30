import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://raid-overseas-promo-labs.trycloudflare.com/api";

  /// تسجيل مستخدم جديد
  static Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$baseUrl/register");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ تم التسجيل بنجاح: ${response.body}');
        return responseData['data']['token'];
      } else if (response.statusCode == 422) {
        print('⚠️ خطأ في البيانات: ${response.body}');
        return null;
      } else {
        print('❌ استجابة غير متوقعة (${response.statusCode}): ${response.body}');
        return null;
      }
    } catch (e) {
      print('🚨 استثناء أثناء التسجيل: $e');
      return null;
    }
  }

  /// تسجيل الدخول
  static Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ تم تسجيل الدخول: ${response.body}');
        return responseData['data']['token'];
      } else if (response.statusCode == 401) {
        print('🚫 بيانات غير صحيحة');
        return null;
      } else {
        print('❌ استجابة غير متوقعة (${response.statusCode}): ${response.body}');
        return null;
      }
    } catch (e) {
      print('🚨 خطأ في الاتصال: $e');
      return null;
    }
  }

  /// إرسال إجابات الأسئلة وتحليلها
  static Future<Map<String, dynamic>?> submitCategoryAnswers({
    required String token,
    required String childId,
    required int categoryId,
    required List<int> answers,
  }) async {
    final url = Uri.parse("$baseUrl/child/category-score");

    final payload = {
      "child_id": childId,
      "category_id": categoryId,
      "answers": answers.map((value) => {"value": value}).toList(),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("✅ النتيجة المستلمة: $responseData");
        return responseData;
      } else {
        print("❌ فشل في الإرسال (${response.statusCode}): $responseData");
        return null;
      }
    } catch (e) {
      print("🚨 خطأ في الإرسال: $e");
      return null;
    }
  }
}

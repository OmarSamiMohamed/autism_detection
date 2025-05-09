import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://snowboard-phones-imagine-kitchen.trycloudflare.com/api";

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
        },
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ تم التسجيل بنجاح: ${response.body}');
        return responseData['data']['token'];
      } else if (response.statusCode == 422) {
        print('⚠ خطأ في البيانات: ${responseData['msg']}');
        if (responseData['data'] is List) {
          for (var error in responseData['data']) {
            print('🔸 $error');
          }
        }
        return null;
      } else {
        print('❌ استجابة غير متوقعة: ${response.statusCode}');
        print('📦 محتوى الاستجابة: ${response.body}');
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
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ تم تسجيل الدخول: ${response.body}');
        return responseData['data']['token'];
      } else if (response.statusCode == 401) {
        print('🚫 بيانات غير صحيحة');
        return null;
      } else {
        print('❌ استجابة غير متوقعة: ${response.statusCode}');
        print('📦 محتوى الاستجابة: ${response.body}');
        return null;
      }
    } catch (e) {
      print('🚨 خطأ في الاتصال: $e');
      return null;
    }
  }
}

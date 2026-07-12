import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../errors/failures.dart';

class ApiService {
  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: headers,
      );
      return response;
    } catch (e) {
      throw NetworkFailure(message: 'Network error: $e');
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      throw NetworkFailure(message: 'Network error: $e');
    }
  }

  Future<http.StreamedResponse> multipartRequest({
    required String endpoint,
    required Map<String, String> headers,
    required Map<String, String> fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ApiConstants.baseUrl}$endpoint'));
      request.headers.addAll(headers);
      request.fields.addAll(fields);
      if (files != null) {
        request.files.addAll(files);
      }
      return await request.send();
    } catch (e) {
      throw NetworkFailure(message: 'Network error: $e');
    }
  }

  Future<String?> loginUser(
      {required String email, required String password}) async {
    // Firebase Auth login implementation would go here
    // For now, returning null as placeholder
    return null;
  }

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Firebase Auth registration implementation would go here
    // For now, returning null as placeholder
    return null;
  }
}

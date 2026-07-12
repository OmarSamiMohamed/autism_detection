import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const String _authMethodKey = 'auth_method';
  static const String _childIdKey = 'child_id';

  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return prefs.getString(_tokenKey);
  }

  Future<void> saveAuthMethod(String method) async {
    await prefs.setString(_authMethodKey, method);
  }

  String? getAuthMethod() {
    return prefs.getString(_authMethodKey);
  }

  Future<void> saveChildId(String childId) async {
    await prefs.setString(_childIdKey, childId);
  }

  String? getChildId() {
    return prefs.getString(_childIdKey);
  }

  Future<void> clearAll() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_authMethodKey);
    await prefs.remove(_childIdKey);
  }

  Future<bool> isLoggedIn() async {
    return prefs.getString(_tokenKey) != null;
  }
}

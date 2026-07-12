import 'package:autism_detection/core/errors/failures.dart';
import 'package:autism_detection/core/services/firebase_service.dart';
import 'package:autism_detection/core/services/storage_service.dart';
import 'package:autism_detection/features/auth/domain/entities/user.dart';
import 'package:autism_detection/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseService firebaseService;
  final StorageService storageService;

  AuthRepositoryImpl(
      {required this.firebaseService, required this.storageService});

  @override
  Future<User?> login(String email, String password) async {
    try {
      final token =
          await firebaseService.loginUser(email: email, password: password);
      if (token != null) {
        await storageService.saveToken(token);
        await storageService.saveAuthMethod('email');
        return User(
          uid: '',
          name: '',
          email: email,
          token: token,
        );
      }
      return null;
    } catch (e) {
      throw UnknownFailure(message: 'Login failed: $e');
    }
  }

  @override
  Future<User?> register(String name, String email, String password) async {
    try {
      final token = await firebaseService.registerUser(
        name: name,
        email: email,
        password: password,
        confirmPassword: password,
      );
      if (token != null) {
        await storageService.saveToken(token);
        await storageService.saveAuthMethod('email');
        return User(
          uid: '',
          name: name,
          email: email,
          token: token,
        );
      }
      return null;
    } catch (e) {
      throw UnknownFailure(message: 'Registration failed: $e');
    }
  }

  @override
  Future<User?> loginWithGoogle() async {
    // Google Sign In implementation
    throw UnimplementedError();
  }

  @override
  Future<User?> loginWithFacebook() async {
    // Facebook Sign In implementation
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    await firebaseService.signOut();
    await storageService.clearAll();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await storageService.isLoggedIn();
  }

  @override
  Future<void> saveToken(String token) async {
    await storageService.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return storageService.getToken();
  }

  @override
  Future<void> saveChildId(String childId) async {
    await storageService.saveChildId(childId);
  }

  @override
  Future<String?> getChildId() async {
    return storageService.getChildId();
  }
}
